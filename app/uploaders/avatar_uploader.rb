class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url(*_args)
    gender = model.gender == 'non_binary' ? 'bottts' : model.gender
    "https://avatars.dicebear.com/api/#{gender}/#{model.first_name}.svg?w=200&h=200"
  end

  process resize_to_fill: [200, 200]

  version :thumb do
    process resize_to_fill: [50, 50]
  end

  def extension_whitelist
    %w[jpg jpeg png]
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
