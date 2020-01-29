class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :project_code, :description, :open
end
