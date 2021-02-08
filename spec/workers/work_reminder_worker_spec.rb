require 'rails_helper'
NUMBER_OF_ELVES = 3

RSpec.describe WorkReminderWorker, type: :worker do
  subject(:worker) { described_class.new }

  before { create_list(:user, NUMBER_OF_ELVES, :elf) }

  it 'deliveres notification emails to elves' do
    delivery = spy
    allow(NotificationMailer).to receive(:work_reminder_email) { delivery }
    worker.perform
    expect(delivery).to have_received(:deliver_later).exactly(NUMBER_OF_ELVES).times
  end
end
