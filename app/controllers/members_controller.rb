require 'json'

class MembersController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :authenticate_user!
  before_action :set_user, only: %i[show create]

  def new
    # return creation form data - experience levels, latest waiver, prices
    # no additional authorisation
    render json: { experienceLevels: ExperienceLevel.all, currentWaiver: Waiver.last }
  end

  def create
    # create member profile, address, photo, waiver signature
    # registration handled by devise
    # current_user matches
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

  def show
    # return selected member with role, profile, address, photo, waiver signature
    # admin required or current_user matches
    return unauthorised_response unless admin_or_user_auth?

    render json: constructed_member
  end

  def index
    # return list of all members for admin dashboard
    # admin required
    return unauthorised_response unless admin_auth?

    render json: all_members.map { |user| constructed_member(user) }
  end

  def update
    # change selected member profile details or other attributes
    # admin required or current_user matches
    return unauthorised_response unless admin_or_user_auth?
  end

  def destroy
    # delete selected member
    # admin required or current_user matches
    return unauthorised_response unless admin_or_user_auth?
  end

  protected

  def all_members
    User.all
        .includes(:user_profile)
        .includes(:user_address)
        .includes(user_photo: { image_attachment: :blob })
        .includes(:signed_waivers)
  end

  def constructed_member(user = @user)
    { user: user,
      profile: user.user_profile,
      address: user.user_address,
      photo: (rails_blob_url(user.user_photo.image) if user.user_photo),
      waiver: user.signed_waivers&.last }
  end
end
