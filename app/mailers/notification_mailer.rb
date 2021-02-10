class NotificationMailer < ApplicationMailer
  def work_reminder_email(email)
    mail to: email, subject: 'Back to work'
  end

  def elf_invite_email(email, invite_link)
    @invite_link = invite_link
    mail to: email, subject: 'Elf registration invite'
  end

  def invite_expiration_email(email, invitee_email)
    @invitee_email = invitee_email
    mail to: email, subject: 'Invite has expired'
  end
end
