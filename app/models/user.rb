class User < ApplicationRecord
  enum gender: { male: 0, female: 1, non_binary: 2 }

  has_many :gifts,       class_name: 'Gift', foreign_key: 'recipient_id', dependent: :destroy
  has_many :gifts_added, class_name: 'Gift', foreign_key: 'added_by_id',  dependent: :nullify

  validates :first_name,  presence: true, length: { maximum: 25 }
  validates :last_name,   presence: true, length: { maximum: 25 }
  validates :middle_name, length: { maximum: 25 }
  validates :address,     presence: true, length: { maximum: 100 }
  validates :gender,      presence: true
  validates :behavior,    presence: true, length: { minimum: 10, maximum: 280 }

  def male?
    gender == 'male'
  end

  def female?
    gender == 'female'
  end

  def non_binary?
    gender == 'non_binary'
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader
end
