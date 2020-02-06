class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :project_code, :description, :default_access, :open, :updated_at
end
