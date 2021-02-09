require 'rails_helper'

RSpec.describe 'Invitations', type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'GET invitations#index' do
    it 'renders an index page' do
      get invitations_path
      expect(response).to render_template :index
    end
  end

  describe 'POST invitation#create' do
    subject(:invitation_attrs) { attributes_for(:invitation) }

    let(:valid_invitation_params) do
      {
        invitation: {
          email: invitation_attrs[:email]
        }
      }
    end

    it 'redirects to the invitations page' do
      post invitations_path, params: valid_invitation_params
      expect(response).to redirect_to invitations_path
    end
  end

  describe 'DELETE invitation#destroy' do
    subject!(:existing_invitation) { create(:invitation) }

    it 'redirects to the invitations page' do
      delete invitation_path(existing_invitation)
      expect(response).to redirect_to invitations_path
    end
  end
end
