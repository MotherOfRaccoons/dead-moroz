require 'sidekiq-scheduler'

class WorkReminderWorker < ApplicationWorker
  def perform
    User.where(role: 'elf').each do |user|
      NotificationMailer.work_reminder_email(user.email).deliver_later
    end
  end
end
