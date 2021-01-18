CarrierWave.configure do |config|
  config.storage = :fog
  config.cache_dir = 'tmp/uploads'

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
    aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
    region: Rails.application.credentials.aws[:region]
  }
  config.fog_directory  = Rails.application.credentials.aws[:bucket_name]
  config.fog_public     = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end
