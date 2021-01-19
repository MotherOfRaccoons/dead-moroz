class Gift < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :added_by,  class_name: 'User', optional: true
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title,       presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 100 }
  validates :images,      length: { maximum: 2, message: 'Only 3 images are allowed. The rest were discarded.' }
end
