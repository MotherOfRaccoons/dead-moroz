class InvitationWorker < ApplicationWorker
  def perform(invitation_id, inviter_email)
    invite = Invitation.find_by(id: invitation_id)
    if invite.present? && invite.pending?
      invite.update(status: 'expired')
      NotificationMailer.invite_expiration_email(inviter_email, invite.email).deliver_later
    end
  end
end
