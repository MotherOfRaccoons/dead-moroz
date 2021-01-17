class Gift < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :added_by,  class_name: 'User', optional: true

  validates :title,       presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 100 }
end
