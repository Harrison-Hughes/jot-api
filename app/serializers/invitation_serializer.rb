class InvitationSerializer < ActiveModel::Serializer
  attributes :id, :project_code, :user_id
end
