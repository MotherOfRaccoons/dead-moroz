class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name,  presence: true, length: { maximum: 25 }
  validates :last_name,   presence: true, length: { maximum: 25 }
  validates :middle_name, length: { maximum: 25 }
  validates :address,     presence: true, length: { maximum: 50 }
  validates :gender,      presence: true
  validates :behavior,    presence: true, length: { minimum: 10, maximum: 280 }

  enum gender: { male: 0, female: 1, non_binary: 2 }
end
