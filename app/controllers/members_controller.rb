require 'json'

class MembersController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :authenticate_user!, except: %i[new]
  before_action :set_user, only: %i[show create update]

  # return creation form data - experience levels, latest waiver, prices
  # no additional authorisation
  def new
    render json: { experienceLevels: ExperienceLevel.all, currentWaiver: Waiver.last }
  end

  # create member profile, address, photo, waiver signature
  # registration handled by devise
  # current_user matches
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

  # return selected member with role, profile, address, photo, waiver signature
  # admin required or current_user matches
  def show
    return unauthorised_response unless admin_or_user_auth?

    render json: constructed_member.merge({ formQueries: { experienceLevels: ExperienceLevel.all } })
  end

  # return list of all members for admin dashboard
  # admin required
  def index
    return unauthorised_response unless admin_auth?

    render json: all_members.map { |user| constructed_member(user) }
  end

  # change selected member profile details or other attributes
  # admin required or current_user matches
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

  # delete selected member
  # admin required
  def destroy
    return unauthorised_response unless admin_auth?

    @user.destroy

    render json: { message: 'Profile successfully deleted.' }, status: :ok
  end

  protected

  # Eager loading image attachment variant records not possible until Rails 7.0
  # https://github.com/rails/rails/pull/40842#issuecomment-860050677
  def all_members
    User.all
        .includes(:user_profile)
        .includes(:user_address)
        .includes(user_photo: { image_attachment: :blob })
        .includes(:signed_waivers)
  end

  def photo_url(user)
    user.user_photo ? polymorphic_url(user.user_photo.image.variant(resize_to_limit: [500, 500]).processed) : ''
  end

  def constructed_member(user = @user)
    { member: { user: user,
                profile: user.user_profile,
                address: user.user_address,
                photo: photo_url(user),
                waiver: user.signed_waivers&.last } }
  end
end
