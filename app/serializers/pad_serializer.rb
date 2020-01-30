class PadSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :points
end
