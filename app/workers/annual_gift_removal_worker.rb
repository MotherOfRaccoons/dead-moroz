require 'sidekiq-scheduler'

class AnnualGiftRemovalWorker < ApplicationWorker
  def perform
    User.elf.with_selected_gifts.pluck(:email, :first_name, :gender).each do |email, first_name, gender|
      CongratulationMailer.congratulation_email(email, first_name, gender).deliver_later
    end
    Gift.where(selected: true).destroy_all
  end
end
