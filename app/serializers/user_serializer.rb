class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_code, :token
  has_many :invitations

  def token
    object.token
  end
end
