class AssessmentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @assessment = @user.assessments_on.create(
      value: asssessment_params[:value],
      comment: asssessment_params[:comment],
      author: current_user
    )
    redirect_to @user, alert: @assessment.errors.full_messages[0]
  end

  def destroy
    Assessment.find(params[:id]).destroy
    redirect_to user_path(User.find(params[:user_id]))
  end

  private

  def asssessment_params
    params.require(:assessment).permit(:id, :value, :comment)
  end
end
