class AnnualGiftRemovalWorker
  include Sidekiq::Worker

  sidekiq_options lock: :until_executed

  def perform
    self.class.perform_at(1.year.from_now)
    Gift.where(selected: true).destroy_all
  end
end
