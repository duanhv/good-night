class Api::V1::UsersController < ApplicationController
  def index
    raise unless current_user

    users = User.all
    render json: users, status: :ok
  end
end
