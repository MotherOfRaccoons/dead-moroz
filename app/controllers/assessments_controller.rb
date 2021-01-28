class AssessmentsController < ApplicationController
  load_and_authorize_resource through: :user, through_association: :assessments_on
  helper_method :user

  def create
    @assessment.author = current_user
    @assessment.save
    redirect_to user, alert: @assessment.errors.full_messages[0]
  end

  def destroy
    @assessment.destroy
    redirect_to user_path(User.find(params[:user_id])), notice: 'Assessment was successfully removed.'
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def assessment_params
    params.require(:assessment).permit(:id, :value, :comment)
  end
end
