class User < ApplicationRecord
  enum gender: { male: 0, female: 1, non_binary: 2 }
  enum role: { kid: 0, elf: 1, santa: 2, admin: 3 }

  has_many :gifts,       class_name: 'Gift', foreign_key: 'recipient_id', dependent: :destroy, inverse_of: :recipient
  has_many :gifts_added, class_name: 'Gift', foreign_key: 'added_by_id',  dependent: :nullify, inverse_of: :added_by

  has_many :reviews_on,  class_name: 'Review', foreign_key: 'reviewee_id', dependent: :destroy, inverse_of: :reviewee
  has_many :reviews_by,  class_name: 'Review', foreign_key: 'reviewer_id', dependent: :nullify, inverse_of: :reviewer

  has_many :assessments_on,  class_name: 'Assessment', foreign_key: 'target_id', dependent: :destroy, inverse_of: :target
  has_many :assessments_by,  class_name: 'Assessment', foreign_key: 'author_id', dependent: :nullify, inverse_of: :author

  validates :first_name,  presence: true, length: { maximum: 25 }
  validates :last_name,   presence: true, length: { maximum: 25 }
  validates :middle_name, length: { maximum: 25 }
  validates :address,     presence: true, length: { maximum: 100 }
  validates :gender,      presence: true
  validates :behavior,    presence: true, length: { minimum: 10, maximum: 280 }
  validates :role,        presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader
  paginates_per 10
end
