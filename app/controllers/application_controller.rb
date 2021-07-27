class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json
  
  protected

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_by_email
    @user = User.find_by(email: params[:email])
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

# Protected methods to be inherited by members and payments controllers
# which serve as an authorisation layer based on the user's role and id.
# Also included are support methods run before actions to set the user and limit params.
