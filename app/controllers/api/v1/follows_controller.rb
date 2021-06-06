class Api::V1::FollowsController < ApplicationController

  def index
    follows = Follow.where(sender_id: current_user.id).order(created_at: :desc)
    render json: follows, status: :ok
  end

  def create
    follow = Follow.create!(follow_params.merge(sender_id: current_user.id))
    render json: follow, status: :ok
  end

  def destroy
    follow = Follow.find_by(sender_id: current_user.id, receiver_id: params["id"])
    raise "Not Found" unless follow

    follow.destroy!
    render json: follow, status: :ok
  end

  private

  def follow_params
    params.permit(:receiver_id)
  end
end
