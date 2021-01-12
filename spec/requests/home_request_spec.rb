require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  it 'sign user in' do
    user = create(:user)
    sign_in user
    get root_path
    expect(response).to render_template :index
  end
end
