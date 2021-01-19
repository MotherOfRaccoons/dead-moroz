require 'rails_helper'

RSpec.describe 'Images', type: :request do
  let(:user) { create(:user) }
  let(:gift) { create(:gift, recipient: user) }

  before { sign_in user }

  describe 'POST images#create' do
    subject(:new_image) { build_stubbed(:image) }

    it 'adds an image with valid parameters' do
      post "/users/#{user.id}/gifts/#{gift.id}/images", params: { image: { image: new_image } }
      expect(response).to redirect_to user_gift_url(user_id: user.id, id: gift.id)
    end
  end

  describe 'DELETE images#destroy' do
    subject!(:existing_image) { create(:image) }

    it 'deletes an existing image' do
      delete "/users/#{user.id}/gifts/#{gift.id}/images", params: { id: existing_image.id }
      expect(response).to redirect_to user_gift_url(user_id: user.id, id: gift.id)
    end
  end
end
