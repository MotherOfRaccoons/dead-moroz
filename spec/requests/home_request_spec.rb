require 'rails_helper'

# Temprorary spec for coverage, will get rid of it later
RSpec.describe 'Homes' do
  it 'sign user in' do
    user = create(:user)
    sign_in user
    get root_path
    expect(response).to render_template :index
  end
end
