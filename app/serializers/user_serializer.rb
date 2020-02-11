class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_code, :token, :default_nickname
  has_many :invitations

  def token
    object.token
  end
end
