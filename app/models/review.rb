class Review < ApplicationRecord
  belongs_to :reviewer, class_name: 'User', optional: true, inverse_of: :reviews_by
  belongs_to :reviewee, class_name: 'User', inverse_of: :reviews_on

  validates :body, presence: true, length: { minimum: 10, maximum: 280 }
end
