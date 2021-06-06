class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at_timestamp

  def created_at_timestamp
  	object.created_at&.to_i
  end
end
