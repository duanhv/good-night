class Api::V1::ClockInsController < ApplicationController

  def index
    clockIns = ClockIn
      .where(user_id: current_user.id)
      .order(id: :desc)

    render json: clockIns, status: :ok
  end

  def create
    ClockIn.create!(clock_in_params.merge(user_id: current_user.id))
    
    clockIns = ClockIn
      .where(user_id: current_user.id)
      .order(id: :desc)

    render json: clockIns, status: :ok
  end

  def clock_in_by_friend
    raise "Not Friend" unless current_user.is_friend?(params[:id])

    clockIns = ClockIn
      .available
      .where(user_id: params[:id])
      .where("created_at >= ?", 7.days.ago)
      .order(sleep_time_in_second: :desc)

    render json: clockIns, status: :ok
  end

  private

  def clock_in_params
    params.permit(:sleep_at, :wake_up_at)
  end
end
