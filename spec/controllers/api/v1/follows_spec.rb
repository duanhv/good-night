require "rails_helper"

RSpec.describe Api::V1::FollowsController, type: :request do
  describe "GET #index" do
    context "when the user hasn't logged in" do
      it "raises error" do
        expect do
          get "/api/v1/follows"
        end.to raise_error("Unauthenticate!")
      end
    end

    context "when the user has logged in" do
      it "returns a list of receivers" do
        sender = FactoryBot.create(:user)
        receiver1 = FactoryBot.create(:user)
        receiver2 = FactoryBot.create(:user) 

        FactoryBot.create(:follow, sender: sender, receiver: receiver1)
        FactoryBot.create(:follow, sender: sender, receiver: receiver2)

        login(sender)
        get "/api/v1/follows"
        expect(json_body.size).to eq 2
      end
    end
  end

  describe "POST #create" do
    context "when receiver does not exsit" do
      it "raises NOT FOUND error" do
        sender = FactoryBot.create(:user)

        login(sender)
        expect do
          post "/api/v1/follows", params: { receiver_id: 10_000_000 }
        end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Receiver must exist")
      end
    end

    context "when receiver exsits" do
      it "creates follow record successfully" do
        sender = FactoryBot.create(:user)
        receiver = FactoryBot.create(:user)

        login(sender)
        expect do
          post "/api/v1/follows", params: { receiver_id: receiver.id }
        end.to change { Follow.count }.by(1)
        expect(json_body["sender_id"]).to eq sender.id
        expect(json_body["receiver_id"]).to eq receiver.id
      end
    end
  end

  describe "DELETE #destroy" do
    it "unfollows" do
      sender = FactoryBot.create(:user)
      receiver = FactoryBot.create(:user)
      FactoryBot.create(:follow, sender: sender, receiver: receiver)

      login(sender)
      expect do
        delete "/api/v1/follows/#{receiver.id}"
      end.to change { Follow.count }.by(-1)
      expect(json_body["sender_id"]).to eq sender.id
      expect(json_body["receiver_id"]).to eq receiver.id
    end
  end
end
