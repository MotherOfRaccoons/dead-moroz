class Invitation < ApplicationRecord
  include AASM

  has_secure_token

  enum status: { pending: 0, done: 1, expired: 2 }

  aasm column: :status, enum: true do
    state :pending, initial: true
    state :done
    state :expired

    event :accept do
      transitions from: :pending, to: :done
    end

    event :expire do
      transitions from: :pending, to: :expired
    end
  end

  validates :email, presence: true, uniqueness: { message: 'was already used' }

  paginates_per 10
end
