class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_code, :token

  def token
    object.token
  end
end
