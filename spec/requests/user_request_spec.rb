require 'rails_helper'

RSpec.describe 'Users', type: :request do
  subject(:user) { create(:user) }

  before { sign_in user }

  describe 'GET users#index' do
    it 'renders an index page' do
      get users_path
      expect(response).to render_template :index
    end
  end

  describe 'GET users#show' do
    it 'renders a user page' do
      get user_path(user)
      expect(response).to render_template :show
    end
  end
end
