require 'rails_helper'

RSpec.describe AnnualGiftRemovalWorker, type: :worker do
  subject(:worker) { described_class.new }

  before do
    create(:gift, selected: true)
    create(:gift, selected: false)
  end

  it 'removes selected gifts' do
    expect { worker.perform }.to change { Gift.selected.count }.by(-1)
  end
end
