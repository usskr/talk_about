class User < ApplicationRecord
  attachment :profile_image
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 30 },
                    uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
end
