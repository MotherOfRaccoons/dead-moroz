require 'rails_helper'

RSpec.describe 'Images', type: :request do
  let(:user) { create(:user) }
  let(:gift) { create(:gift, recipient: user) }

  before { sign_in user }

  describe 'POST images#create' do
    subject(:new_image) { build_stubbed(:image) }

    it 'adds an image with valid parameters' do
      post user_gift_images_path(user, gift), params: { image: { image: new_image } }
      expect(response).to redirect_to user_gift_url(user_id: user.id, id: gift.id)
    end

    it 'fails when image is not provided' do
      post user_gift_images_path(user, gift)
      follow_redirect!
      expect(response.body).to include('Choose an image first')
    end
  end

  describe 'DELETE images#destroy' do
    subject!(:existing_image) { create(:image, gift: gift) }

    it 'deletes an existing image' do
      delete user_gift_images_path(user, gift), params: { id: existing_image.id }
      expect(response).to redirect_to user_gift_url(user_id: user.id, id: gift.id)
    end
  end
end
