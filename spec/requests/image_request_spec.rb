require 'rails_helper'

RSpec.describe 'Images', type: :request do
  let(:user) { create(:user) }
  let(:gift) { create(:gift, recipient: user) }

  before { sign_in user }

  describe 'POST images#create' do
    subject(:new_image) { build_stubbed(:image) }

    context 'with valid parameters' do
      it 'redirects to the gift page' do
        post user_gift_images_path(user, gift), params: { image: { image: new_image } }
        expect(response).to redirect_to [user, gift]
      end

      it 'creates an image' do
        expect do
          post user_gift_images_path(user, gift), params: { image: { image: new_image } }
        end.to change(Image, :count).by(1)
      end
    end

    context 'when image is not provided' do
      specify do
        post user_gift_images_path(user, gift)
        follow_redirect!
        expect(response.body).to include('Choose an image first')
      end
    end
  end

  describe 'DELETE images#destroy' do
    subject!(:existing_image) { create(:image, gift: gift) }

    it 'redirects to the gift page' do
      delete user_gift_images_path(user, gift), params: { id: existing_image.id }
      expect(response).to redirect_to [user, gift]
    end

    it 'destoys an image' do
      expect do
        delete user_gift_images_path(user, gift), params: { id: existing_image.id }
      end.to change(Image, :count).by(-1)
    end
  end
end
