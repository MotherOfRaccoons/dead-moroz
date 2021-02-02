class NotificationMailer < ApplicationMailer
  def work_reminder_email(email)
    mail to: email, subject: 'Back to work'
  end
end
