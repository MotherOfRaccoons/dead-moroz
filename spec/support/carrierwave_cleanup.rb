RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf(Dir.glob(Rails.root.join("#{CarrierWave::Uploader::Base.cache_dir}/*")))
    FileUtils.rm_rf(Dir.glob(Rails.root.join("public/#{CarrierWave::Uploader::Base.store_dir}/test/*")))
  end
end
