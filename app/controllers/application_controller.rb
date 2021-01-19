class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    keys = %i[first_name last_name middle_name birthdate gender address behavior avatar avatar_cache]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys << :remove_avatar)
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
