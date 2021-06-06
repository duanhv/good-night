class ClockInSerializer < ActiveModel::Serializer
  attributes :id, :sleep_at_timestamp, :wake_up_at_timestamp,
  	:sleep_time_in_second, :created_at_timestamp

  def sleep_at_timestamp
    object.sleep_at&.to_i
  end

  def wake_up_at_timestamp
    object.wake_up_at&.to_i
  end

  def created_at_timestamp
    object.created_at&.to_i
  end
end
