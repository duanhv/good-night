class ClockIn < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :sleep_at, presence: true
  validate :ensure_valid_wake_up_at

  before_save :update_sleep_time_in_second

  scope :available, -> { where.not(wake_up_at: nil) }

  private

  def update_sleep_time_in_second
    return if wake_up_at.nil?

    self.sleep_time_in_second = wake_up_at.to_i - sleep_at.to_i
  end

  def ensure_valid_wake_up_at
    return if wake_up_at.nil?

    errors.add(:wake_up_at, "must be greater than sleep_at") if sleep_at.after?(wake_up_at)
  end
end
