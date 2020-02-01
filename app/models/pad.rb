class Pad < ApplicationRecord
  belongs_to :project
  has_many :points, dependent: :destroy

  validates :name, :description , presence: true
end
