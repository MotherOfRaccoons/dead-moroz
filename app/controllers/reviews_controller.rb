class ReviewsController < ApplicationController
  load_and_authorize_resource through: :user, through_association: :reviews_on

  def create
    @review.reviewee = user
    @review.save
    redirect_to user, alert: @review.errors.full_messages_for(:body)[0]
  end

  def destroy
    Review.find(params[:id]).discard
    redirect_to user, notice: 'Review was successfully removed.'
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def review_params
    params.require(:review).permit(:id, :body)
  end
end
