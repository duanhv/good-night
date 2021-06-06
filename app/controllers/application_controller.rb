class ApplicationController < ActionController::API
  before_action :require_login

  def require_login
    raise "Unauthenticate!" unless current_user
  end

  def current_user
    # TODO: implement authentication
    User.first if Rails.env.development?
  end
end
