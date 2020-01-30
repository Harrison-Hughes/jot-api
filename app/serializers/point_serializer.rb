class PointSerializer < ActiveModel::Serializer
  attributes :id, :text, :author, :location, :pad_id, :created_at
end
