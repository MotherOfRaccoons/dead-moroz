require 'rails_helper'

RSpec.describe InvitationWorker, type: :worker do
  let(:user) { build_stubbed(:user) }
  let(:invitation) { create(:invitation, :pending) }

  it 'deliveres an email' do
    described_class.perform_async(invitation.id, user.email)
    expect(NotificationMailer.deliveries).not_to be_empty
  end
end
