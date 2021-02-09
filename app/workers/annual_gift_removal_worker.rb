require 'sidekiq-scheduler'

class AnnualGiftRemovalWorker < ApplicationWorker
  def perform
    User.elf.with_selected_gifts.each do |user|
      CongratulationMailer.congratulation_email(user).deliver_later
    end
    Gift.where(selected: true).destroy_all
  end
end
