class PointSerializer < ActiveModel::Serializer
  attributes :id, :text, :author, :location
end
