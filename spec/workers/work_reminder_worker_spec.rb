require 'rails_helper'
NUMBER_OF_ELVES = 3

RSpec.describe WorkReminderWorker, type: :worker do
  before do
    NUMBER_OF_ELVES.times { create(:user, :elf) }
  end

  it 'deliveres notification emails to elves' do
    described_class.perform_async
    expect(NotificationMailer.deliveries.size).to eq(NUMBER_OF_ELVES)
  end
end
