class Project < ApplicationRecord
  has_many :collaborations, dependent: :destroy
  has_many :users, through: :collaborations
  has_many :pads, dependent: :destroy
end
