require 'sidekiq-scheduler'

class AnnualGiftRemovalWorker
  include Sidekiq::Worker

  def perform
    Gift.where(selected: true).destroy_all
  end
end
