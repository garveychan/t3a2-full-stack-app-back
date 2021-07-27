require 'json'

class MembersController < ApplicationController
  include Rails.application.routes.url_helpers
  # Devise to handle authentication with JWTs
  before_action :authenticate_user!, except: %i[new]
  before_action :set_user, only: %i[show create update]

  # Respond with form data for onboarding -
  # experience levels, latest waiver, and prices (future iteration).
  # No authorisation layer required.
  def new
    render json: { experienceLevels: ExperienceLevel.all, currentWaiver: Waiver.last }
  end

  # User has been signed up via Devise. This action creates the associated
  # profile, address, photo, and signed waiver records as part of onboarding.
  # Attempted associations for the user must match the user specified by the JWT.
  def create
    return unauthorised_response unless user_auth?

    @profile = JSON.parse(params[:profileData])

    @user.create_user_profile!({ date_of_birth: @profile['dateOfBirth'],
                                 first_name: @profile['firstName'],
                                 last_name: @profile['lastName'],
                                 phone_number: @profile['phoneNumber'],
                                 experience_level_id: @profile['climbingExperience'] })

    @user.create_user_address!({ city: @profile['city'],
                                 country: @profile['country'],
                                 postcode: @profile['postcode'],
                                 state: @profile['state'],
                                 street_address: @profile['street'] })

    @user.signed_waivers.create!({
                                   waiver_id: 1,
                                   name: @profile['waiverName'],
                                   signatureURI: @profile['waiverSignatureURI']
                                 })

    @user.create_user_photo!
    @user.user_photo.image.attach(params[:profilePhoto])

    render json: { message: 'Profile successfully created!' }, status: :ok
  end

  # Respond with the user account, associated profile, address, photo, waiver records,
  # and criteria for populating the edit profile interface.
  # Only an admin or the user identified by the JWT can access this endpoint. 
  def show
    return unauthorised_response unless admin_or_user_auth?

    render json: constructed_member.merge({ formQueries: { experienceLevels: ExperienceLevel.all } })
  end

  # Respond with a full list of all members and associated records
  # for populating the relevant admin dashboard section.
  # Only an admin can access this endpoint.
  def index
    return unauthorised_response unless admin_auth?

    render json: all_members.map { |user| constructed_member(user) }
  end

  # change selected member profile details or other attributes
  # admin required or current_user matches
  # Interpret the payload from the PUT request to update the selected member's
  # profile details and other associated attributes if included.
  # A user may only update the record identified by its JWT unless they're an admin.
  def update
    return unauthorised_response unless admin_or_user_auth?

    @profile = JSON.parse(params[:profileData])

    @user.update(email: @profile['email'])

    @user.user_profile.update( date_of_birth: @profile['dateOfBirth'],
                                 first_name: @profile['firstName'],
                                 last_name: @profile['lastName'],
                                 phone_number: @profile['phoneNumber'],
                                 experience_level_id: @profile['climbingExperience'] )

    @user.user_address.update( city: @profile['city'],
                                 country: @profile['country'],
                                 postcode: @profile['postcode'],
                                 state: @profile['state'],
                                 street_address: @profile['street'] )

    @user.user_photo.image.attach(params[:profilePhoto]) if @profile['profilePhoto']

    @user.update(password: @profile['password']) if @profile['password']

    render json: { message: 'Profile successfully updated.' }, status: :ok
  end

  # Destroy the user record specified by the params and authorised by the JWT.
  # All associations are dependent on the user record and will be deleted as well.
  def destroy
    return unauthorised_response unless admin_auth?

    @user.destroy

    render json: { message: 'Profile successfully deleted.' }, status: :ok
  end

  protected

  # Fetch all user records along with associated information.
  # Note that eager loading image attachment variant records is not supported until Rails 7.0
  # https://github.com/rails/rails/pull/40842#issuecomment-860050677
  def all_members
    User.all
        .includes(:user_profile)
        .includes(:user_address)
        .includes(user_photo: { image_attachment: :blob })
        .includes(:signed_waivers)
  end

  # If a user has a profile photo, return the url of the resized variant (creates one the first time)
  def photo_url(user)
    user.user_photo ? polymorphic_url(user.user_photo.image.variant(resize_to_limit: [500, 500]).processed) : ''
  end

  # Construct the member payload based on the user and its associations.
  def constructed_member(user = @user)
    { member: { user: user,
                profile: user.user_profile,
                address: user.user_address,
                photo: photo_url(user),
                waiver: user.signed_waivers&.last } }
  end
end
