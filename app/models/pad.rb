class Pad < ApplicationRecord
  belongs_to :project
  has_many :points, dependent: :destroy

  validates :name, :description , presence: true

  # def collaboratorIDs
  #   self.project.collaborations.map{ |collab| collab.user_id }
  # end 
end
