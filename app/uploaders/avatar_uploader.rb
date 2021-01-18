class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include DefaultUploader

  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url(*_args)
    gender = model.gender == 'non_binary' ? 'bottts' : model.gender
    "https://avatars.dicebear.com/api/#{gender}/#{model.first_name + model.last_name}.svg?w=200&h=200"
  end

  process resize_to_fill: [200, 200]

  version :thumb do
    process resize_to_fill: [50, 50]
  end
end
