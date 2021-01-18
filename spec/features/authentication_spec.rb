require 'rails_helper'

RSpec.describe 'Authentication', driver: :selenium_chrome_headless, js: true do
  let(:user) { build_stubbed(:user) }
  let(:registered_user) { create(:user) }

  it 'lets a user to sign up' do
    visit '/'
    click_link 'Register'
    within('form') do
      fill_in 'user_first_name',            with: user.first_name
      fill_in 'user_last_name',             with: user.last_name
      fill_in 'user_email',                 with: user.email
      fill_in 'user_address',               with: user.address
      fill_in 'user_birthdate',             with: user.birthdate
      fill_in 'user_behavior',              with: user.behavior
      fill_in 'user_password',              with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation
      find('label', text: 'Female').click
    end
    click_button 'Sign up'
    expect(page).to have_content 'You have signed up successfully'
  end

  it 'lets a registered user to sign in' do
    visit '/'
    click_link('Login')
    within('form') do
      fill_in 'user_email',    with: registered_user.email
      fill_in 'user_password', with: registered_user.password
    end
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end

  it 'lets a signed in user to edit profile' do
    sign_in registered_user
    visit '/'
    click_link('Edit profile')
    within('#user_info_form') do
      fill_in 'user_middle_name',      with: 'Johnsonovich'
      fill_in 'user_current_password', with: registered_user.password_confirmation
    end
    click_button 'Update'
    expect(page).to have_content 'Your account has been updated'
  end

  it 'lets a signed in user to sign out' do
    sign_in registered_user
    visit '/'
    click_link('Logout')
    expect(page).to have_content 'Signed out successfully'
  end
end
