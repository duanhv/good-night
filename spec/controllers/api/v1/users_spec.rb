require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :request do
  def mock_current_user(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  context "when get a list of user" do
    it "returns a list of users" do
      user = FactoryBot.create(:user)
      mock_current_user(user)
      get "/api/v1/users"
    end
  end
end
