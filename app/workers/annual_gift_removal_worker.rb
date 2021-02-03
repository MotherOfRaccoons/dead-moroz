require 'sidekiq-scheduler'

class AnnualGiftRemovalWorker < ApplicationWorker
  def perform
    Gift.where(selected: true).destroy_all
  end
end
