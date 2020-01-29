class User < ApplicationRecord
  has_many :collaborations, dependent: :destroy
  has_many :projects, through: :collaborations
end
