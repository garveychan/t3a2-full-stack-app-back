# Checkins controller inherits from members which inherits from application controller.
# This lets us access and use the protected authorisation methods with before action filters.
class CheckinsController < MembersController
  skip_before_action :authenticate_user!, only: %i[create]
  skip_before_action :set_user, only: %i[create]
  before_action :set_user_by_email, only: %i[create]

  # Create a new record of a check-in via the email POSTed from the landing page.
  # No authentication or authorisation required, although the associated user must exist.
  def create
    if @user
      @user.check_ins.create!
      render json: { message: 'Member successfully checked in.', memberName: @user.user_profile&.first_name },
             status: :created
    else
      render json: { message: 'Member could not be found.' }, status: :not_found
    end
  end

  # Respond with a full list of check-ins based on the specified timeframe.
  # The payload includes the profile information of the members in the list for display.
  # Individual member paylods are constructed using an inherited method.
  # Only a admin may request this information.
  def index
    return unauthorised_response unless admin_auth?

    render json: { checkInList: all_checkins.reverse, members: all_checked_in_members.map do |member|
                                                                 constructed_member(member)
                                                               end }
  end

  private

  # Specify the age threshold of requested check-ins.
  def threshold
    1.year.ago
  end

  # Return all check-in records after the age threshold.
  def all_checkins
    CheckIn.since(threshold)
  end

  # Return the members who have checked in and eager load their associations.
  def all_checked_in_members
    User.checked_in_after(threshold).includes(:user_profile, :user_address, :signed_waivers,
                                              { user_photo: { image_attachment: :blob } })
  end
end
