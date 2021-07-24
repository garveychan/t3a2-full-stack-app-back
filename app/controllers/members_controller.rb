class MembersController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :authenticate_user!, except: %i[new]
  before_action :set_user, only: %i[show]

  def new
    # return creation form data - experience levels, latest waiver, prices
    # no additional authorisation
    render json: { experienceLevels: ExperienceLevel.all, currentWaiver: Waiver.last }
  end

  def create
    # create member profile, address, photo, waiver signature
    # registration handled by devise
    # current_user matches
  end

  def show
    # return selected member with role, profile, address, photo, waiver signature
    # admin required or current_user matches

    render json: constructed_member
  end

  def index
    # return list of all members for admin dashboard
    # admin required

    @users = User.all
                 .includes(:user_profile)
                 .includes(:user_address)
                 .includes(user_photo: { image_attachment: :blob })
                 .includes(:signed_waivers)

    render json: @users.map { |user| constructed_member(user) }
  end

  def update
    # change selected member profile details or other attributes
    # admin required or current_user matches
  end

  def destroy
    # delete selected member
    # admin required
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def constructed_member(user = @user)
    { user: user,
      profile: user.user_profile,
      address: user.user_address,
      photo: (rails_blob_url(user.user_photo.image) if user.user_photo),
      waiver: user.signed_waivers&.last }
  end
end
