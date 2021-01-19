class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include DefaultUploader

  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/"
  end

  process resize_to_fill: [300, 300]
end
