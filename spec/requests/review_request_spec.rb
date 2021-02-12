require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'POST review#create' do
    subject(:review_attrs) { attributes_for(:review) }

    let(:valid_review_params) do
      {
        review: {
          body: review_attrs[:body]
        }
      }
    end

    it 'redirects to the user page' do
      post user_reviews_path(user), params: valid_review_params
      expect(response).to redirect_to user
    end

    it 'creates a review' do
      expect do
        post user_reviews_path(user), params: valid_review_params
      end.to change(Review, :count).by(1)
    end
  end

  describe 'DELETE review#destroy' do
    subject!(:existing_review) { create(:review, reviewee: user) }

    it 'redirects to the user page' do
      delete user_reviews_path(user), params: { id: existing_review.id }
      expect(response).to redirect_to user
    end

    it 'destroys a review' do
      expect do
        delete user_reviews_path(user), params: { id: existing_review.id }
      end.to change(Review, :count).by(-1)
    end
  end
end
