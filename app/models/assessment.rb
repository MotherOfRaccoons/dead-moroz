class Assessment < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true, inverse_of: :assessments_by
  belongs_to :target, class_name: 'User', inverse_of: :assessments_on

  validates :target, uniqueness: { scope: :author }
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :comment, length: { minimum: 5, maximum: 280 }
end
