class ApplicationController < ActionController::Base
  SIGN_UP_PERMITTED_KEYS = %i[first_name last_name middle_name birthdate gender address behavior avatar avatar_cache]
  ACCOUNT_UPDATE_PERMITTED_KEYS = SIGN_UP_PERMITTED_KEYS + [:remove_avatar]

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: SIGN_UP_PERMITTED_KEYS)
    devise_parameter_sanitizer.permit(:account_update, keys: ACCOUNT_UPDATE_PERMITTED_KEYS)
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
