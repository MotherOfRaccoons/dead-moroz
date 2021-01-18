require 'rails_helper'

RSpec.describe 'Gifts', type: :request do
  let(:user) { create(:user) }
  let(:gift_attrs) { attributes_for(:gift) }
  let(:existing_gift) { create(:gift) }

  before { sign_in user }

  describe 'GET gifts#index' do
    it 'renders an index page' do
      get "/users/#{user.id}/gifts"
      expect(response).to render_template :index
    end
  end

  describe 'GET gifts#new' do
    it 'renders gift creation page' do
      get "/users/#{user.id}/gifts/new"
      expect(response).to render_template :new
    end
  end

  describe 'POST gifts#create' do
    let(:image) { create(:image) }

    it 'creates a gift with valid parameters' do
      post "/users/#{user.id}/gifts", params: { gift: { title: gift_attrs[:title],
                                                        description: gift_attrs[:description],
                                                        images_attributes: { '0': { image: [image] } } } }
      expect(response).to redirect_to action: :index
    end

    it 'fails to create a gift with invalid parameters' do
      post "/users/#{user.id}/gifts", params: { gift: { title: '', description: '' } }
      expect(response).to render_template :new
    end
  end

  describe 'PATCH gifts#update' do
    it 'updates a gift with valid parameters' do
      patch "/users/#{user.id}/gifts/#{existing_gift.id}", params: { gift: { description: existing_gift[:description] } }
      expect(response).to redirect_to assigns(gift_attrs)
    end

    it 'fails to update a gift with invalid parameters' do
      patch "/users/#{user.id}/gifts/#{existing_gift.id}", params: { gift: { title: '' } }
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE gifts#destroy' do
    it 'deletes an existing gift' do
      delete "/users/#{user.id}/gifts/#{existing_gift.id}"
      expect(response).to redirect_to action: :index
    end
  end
end
