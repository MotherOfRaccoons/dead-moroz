class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :middle_name, length: {maximum: 50}
  validates :address, presence: true, length: {maximum: 50}
  validates :gender, presence: true
  validates :behavior, presence: true, length: {minimum: 10, maximum: 280}

  enum gender: [:male, :female, :non_binary]
end
