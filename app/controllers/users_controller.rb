class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(user_params[:id])
    @assessment = @user.assessments_on.find_by(author: current_user)
  end

  private

  def user_params
    params.permit(:id)
  end
end
