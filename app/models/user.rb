class User < ApplicationRecord
  has_secure_password
  has_many :collaborations, dependent: :destroy
  has_many :projects, through: :collaborations
  has_many :invitations

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  def token
    JWT.encode({ user_id: self.id }, Rails.application.credentials.jwt)
  end 

end
