class Invitation < ApplicationRecord
  has_secure_token

  enum status: { pending: 0, done: 1, expired: 2 }

  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :email,  presence: true, uniqueness: { message: 'was already used' }
end
