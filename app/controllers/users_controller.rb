class UsersController < ApplicationController
  helper_method :user

  def index
    @users = User.page(user_params[:page])
  end

  def show
    @assessment = user.assessments_on.find_by(author: current_user)

    respond_to do |format|
      format.js { @translation = GoogleTranslate.translate(@user.cache_key_with_version, @user.behavior) }
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
