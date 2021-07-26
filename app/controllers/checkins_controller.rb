class CheckinsController < MembersController
  skip_before_action :authenticate_user!, only: %i[create]
  skip_before_action :set_user, only: %i[create]
  before_action :set_user_by_email, only: %i[create]

  def create
    # create a new check-in from POSTed email matched to user and add it to the log
    # no auth/auth required
    if @user
      @user.check_ins.create!
      render json: { message: 'Member successfully checked in.', memberName: @user.user_profile&.first_name }, status: :created
    else
      render json: { message: 'Member could not be found.' }, status: :not_found
    end
  end

  def index
    # return full list of check-ins from the past week (interim timeframe)
    # admin required
    return unauthorised_response unless admin_auth?

    render json: { checkInList: all_checkins.reverse, members: all_checked_in_members.map do |member|
                                                         constructed_member(member)
                                                       end }
  end

  private

  def threshold
    1.day.ago
  end

  def all_checkins
    CheckIn.since(threshold)
  end

  def all_checked_in_members
    User.checked_in_after(threshold).includes(:user_profile, :user_address, :signed_waivers,
                                              { user_photo: { image_attachment: :blob } })
  end

  def constructed_checkin(checkin)
    { user: constructed_member(checkin.user),
      checkInTimestamp: checkin.created_at }
  end
end
