require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'POST review#create' do
    subject(:review_attrs) { attributes_for(:review) }

    it 'creates a review' do
      post "/users/#{user.id}/reviews/", params: {
        review: {
          body: review_attrs[:body]
        }
      }
      expect(response).to redirect_to user
    end
  end

  describe 'DELETE review#destroy' do
    subject!(:existing_review) { create(:review) }

    it 'deletes an existing review' do
      delete "/users/#{user.id}/reviews", params: { id: existing_review.id }
      expect(response).to redirect_to user
    end
  end
end
