class PadSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :project_id, :created_at, :updated_at
  has_many :points
end
