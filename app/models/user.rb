# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :description, :alipay
  has_secure_password
  has_many :books, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { minimum: 2, maximum: 50 },
                   uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 3, maximum: 150 }
  validates :password, length: { minimum: 6, maximum: 80 }
  validates :password_confirmation, presence: true
  validates :description, length: { maximum: 800 }
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
