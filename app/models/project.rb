class Project < ApplicationRecord
  has_many :collaborations, dependent: :destroy
  has_many :users, through: :collaborations
  has_many :pads, dependent: :destroy

  validates :name, :description , presence: true

  def createProjectWithUserId(name:, description:, open:, id:)

  end

end
