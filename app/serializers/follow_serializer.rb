class FollowSerializer < ActiveModel::Serializer
  attributes :id, :sender_id, :receiver_id, :created_at_timestamp

  def created_at_timestamp
  	object.created_at&.to_i
  end
end
