class User < ApplicationRecord
  has_secure_password
  has_many :collaborations, dependent: :destroy
  has_many :projects, through: :collaborations

  validates :email, uniqueness: true
end
