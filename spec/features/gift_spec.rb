require 'rails_helper'

RSpec.describe 'Gifts', type: :feature, driver: :selenium_chrome_headless, js: true do
  let(:user) { create(:user) }
  let(:gift_attrs) { attributes_for(:gift) }

  before { sign_in user }

  it 'can be added' do
    visit "users/#{user.id}/gifts"
    click_on 'New gift'
    within('form') do
      fill_in 'gift_title',       with: gift_attrs[:title]
      fill_in 'gift_description', with: gift_attrs[:description]
    end
    click_button 'Create'
    expect(page).to have_content 'Gift was successfully created'
  end

  context 'when exists' do
    subject!(:gift) { create(:gift, recipient: user) }

    it 'can be edited' do
      visit "users/#{user.id}/gifts"
      click_on 'Edit'
      within('form') do
        fill_in 'gift_description', with: 'New description'
      end
      click_button 'Save'
      expect(page).to have_content 'Gift was successfully updated'
    end

    it 'can be removed' do
      visit "users/#{user.id}/gifts"
      accept_confirm do
        click_on 'Remove'
      end
      expect(page).to have_content 'Gift was successfully removed'
    end
  end
end
