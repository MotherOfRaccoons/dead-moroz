class Image < ApplicationRecord
  belongs_to :gift
  validates_associated :gift

  mount_uploader :image, ImageUploader
end
