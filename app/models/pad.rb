class Pad < ApplicationRecord
  belongs_to :project
  has_many :points, dependent: :destroy
end
