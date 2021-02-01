Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL') }

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL') }

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end

  Rails.application.config.after_initialize do
    date = DateTime.parse(1.year.from_now.strftime("%Y-01-01"))
    AnnualGiftRemovalWorker.perform_at(date)
  end
end
