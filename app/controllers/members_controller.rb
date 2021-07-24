class MembersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]
  before_action :set_member, only: %i[show]

  def new
    # return creation form data - experience levels, countries, latest waiver, prices
    # no additional authorisation
  end

  def create
    # create member profile, address, photo, waiver signature
    # registration handled by devise
    # current_user matches
  end

  def show
    # return selected member with role, profile, address, photo, waiver signature
    # admin required or current_user matches

    render json: @member
  end

  def index
    # return list of all members for admin dashboard
    # admin required
    @members = User.all

    render json: @members
  end

  def edit
    # return selected member profile information for editing
    # admin required or current_user matches
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

  def set_member
    @user = User.find(params[:id])
  end

  def construct_member; end
end
