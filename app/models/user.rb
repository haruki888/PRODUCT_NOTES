class User < ApplicationRecord
  # before_save { self.email = email.downcase }

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: { maximum: 50 },
  #                   format: { with: VALID_EMAIL_REGEX },
  #                   uniqueness: true
  validates :store_id, presence: true, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
