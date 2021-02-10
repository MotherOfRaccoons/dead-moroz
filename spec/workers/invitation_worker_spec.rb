require 'rails_helper'

RSpec.describe InvitationWorker, type: :worker do
  subject(:worker) { described_class.new }

  let(:user) { build_stubbed(:user) }
  let(:invitation) { create(:invitation, :pending) }

  it 'deliveres an email' do
    expect(NotificationMailer).to receive_message_chain(:invite_expiration_email, :deliver_later)
    worker.perform(invitation.id, user.email)
  end
end
