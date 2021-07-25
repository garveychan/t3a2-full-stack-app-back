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

    puts params

    if user_auth?

      render json: { message: 'success!' }, status: :ok
    end

    unauthorised_response unless performed?
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
