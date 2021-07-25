require 'json'

class MembersController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :authenticate_user!, except: %i[new]
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
    render json: constructed_member if admin_or_user_auth?
    unauthorised_response unless performed?
  end

  def index
    # return list of all members for admin dashboard
    # admin required
    render json: all_members.map { |user| constructed_member(user) } if admin_auth?
    unauthorised_response unless performed?
  end

  def update
    # change selected member profile details or other attributes
    # admin required or current_user matches
    if admin_or_user_auth?

    end
  end

  def destroy
    # delete selected member
    # admin required or current_user matches
    if admin_or_user_auth?

    end
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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def member_params
    params.permit(:id, :profilePhoto, :profileData)
  end

  def user_auth?
    current_user.id == @user.id
  end

  def admin_auth?
    current_user.admin_role?
  end

  def admin_or_user_auth?
    user_auth? || admin_auth?
  end

  def unauthorised_response
    render json: { message: "You're not authorised to do that." }, status: :unauthorized
  end
end
