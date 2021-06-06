class User < ApplicationRecord
  def is_friend?(friend_id)
    Follow.exists?(sender_id: id, receiver_id: friend_id) ||
      Follow.exists?(sender_id: friend_id, receiver_id: id)
  end
end
