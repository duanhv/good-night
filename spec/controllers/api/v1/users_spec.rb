require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :request do
  context "when the user hasn't logged in" do
    it "raises error" do
      expect do
        get "/api/v1/users"
      end.to raise_error("Unauthenticate!")
    end
  end

  context "when the user has logged in" do
    it "returns a list of users" do
      user = FactoryBot.create(:user)
      login(user)
      get "/api/v1/users"
      expect(json_body.size).to eq 1
    end
  end
end
