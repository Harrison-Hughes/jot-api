class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_code, :token
end
