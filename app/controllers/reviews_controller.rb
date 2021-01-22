class ReviewsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @review = @user.reviews_on.create(body: review_params[:body], reviewer: current_user)
    redirect_to @user, alert: @review.errors.full_messages_for(:body)[0]
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to user_path(User.find(params[:user_id]))
  end

  private

  def review_params
    params.require(:review).permit(:id, :body)
  end
end
