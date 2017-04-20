class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def confirm_user_type(user_type)
     unless current_user.is_a?(user_type)
       sign_out(current_user)
       redirect_to new_user_session_path
     end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :type])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :type])

  end
end
