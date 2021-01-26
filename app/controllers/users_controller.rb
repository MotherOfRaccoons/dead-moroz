class UsersController < ApplicationController
  load_and_authorize_resource
  helper_method :user

  def index
    @users = @users.page(user_params[:page])
  end

  def show
    @assessment = user.assessments_on.find_by(author: current_user)

    respond_to do |format|
      format.js do
        @translation = Rails.cache.fetch(['translate', user.cache_key_with_version], expires_in: 1.hour) do
          GoogleTranslate.translate(@user.behavior)
        end
      end
      format.html
    end
  end

  private

  def user
    @user ||= User.find(user_params[:id])
  end

  def user_params
    params.permit(:id, :page)
  end
end
