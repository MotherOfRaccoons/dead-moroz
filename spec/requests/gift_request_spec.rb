require 'rails_helper'

RSpec.describe 'Gifts', type: :request do
  let(:user) { create(:user) }
  let(:gift_attrs) { attributes_for(:gift) }
  let!(:existing_gift) { create(:gift, recipient: user) }
  let(:valid_gift_params) do
    {
      gift: {
        title: gift_attrs[:title],
        description: gift_attrs[:description],
        images_attributes: { '0': { image: [image] } }
      }
    }
  end

  before { sign_in user }

  describe 'GET gifts#index' do
    it 'renders an index page' do
      get user_gifts_path(user)
      expect(response).to render_template :index
    end
  end

  describe 'GET gifts#new' do
    it 'renders gift creation page' do
      get new_user_gift_path(user)
      expect(response).to render_template :new
    end
  end

  describe 'POST gifts#create' do
    let(:image) { create(:image) }

    context 'with valid parameters' do
      it 'redirects to the index page' do
        post user_gifts_path(user), params: valid_gift_params
        expect(response).to redirect_to action: :index
      end
    end

    context 'with invalid parameters' do
      it 'renders a :new template' do
        post user_gifts_path(user), params: { gift: { title: '', description: '' } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH gifts#update' do
    context 'with valid parameters' do
      it 'redirects to the gift page' do
        patch user_gift_path(user, existing_gift), params: { gift: { description: existing_gift[:description] } }
        expect(response).to redirect_to assigns(gift_attrs)
      end
    end

    context 'with invalid parameters' do
      it 'renders an :edit template' do
        patch user_gift_path(user, existing_gift), params: { gift: { title: '' } }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE gifts#destroy' do
    it 'redirects to the index page' do
      delete user_gift_path(user, existing_gift)
      expect(response).to redirect_to action: :index
    end
  end
end
