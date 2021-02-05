require 'rails_helper'

RSpec.describe AnnualGiftRemovalWorker, type: :worker do
  before { create(:gift, selected: true) }

  let!(:not_selected_gift) { create(:gift) }

  it 'removes selected gifts' do
    described_class.perform_async
    expect(Gift.all).to contain_exactly(not_selected_gift)
  end
end
