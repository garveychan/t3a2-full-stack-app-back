class CheckinsController < MembersController
  def create
    # create a new check-in from POSTed email matched to user and add it to the log
    # no auth/auth required
  end

  def index
    # return full list of check-ins from the past week (interim timeframe)
    # admin required
    return unauthorised_response unless admin_auth?

    render json: all_checkins.map { |checkin| constructed_checkin(checkin) }
  end

  protected

  def all_checkins
    CheckIn.all
  end

  def constructed_checkin(checkin)
    { user: constructed_member(checkin.user),
      checkInTimestamp: checkin.created_at }
  end
end
