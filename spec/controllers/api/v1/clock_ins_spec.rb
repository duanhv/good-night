require "rails_helper"

RSpec.describe Api::V1::ClockInsController, type: :request do
  describe "GET #index" do
    context "when the user hasn't logged in" do
      it "raises error" do
        expect do
          get "/api/v1/clock_ins"
        end.to raise_error("Unauthenticate!")
      end
    end

    context "when the user has logged in" do
      it "returns a list of clock-ins" do
        user = FactoryBot.create(:user)
        FactoryBot.create_list(:clock_in, 5, user: user)

        login(user)
        get "/api/v1/clock_ins"
        expect(json_body.size).to eq 5
      end
    end
  end

  describe "POST #create" do
    context "when does not have sleep_at data" do
      it "raises error" do
        user = FactoryBot.create(:user)

        login(user)
        expect do
          post "/api/v1/clock_ins", params: {}
        end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Sleep at can't be blank")
      end
    end

    context "when has sleep_at data" do
      it "creates clock_in record successfully and return all clock-in times ordered by create_at" do
        user = FactoryBot.create(:user)

        login(user)
        expect do
          travel_to 1.minutes.from_now do
            post "/api/v1/clock_ins", params: { sleep_at: Time.current }
          end
          travel_to 2.minutes.from_now do
            post "/api/v1/clock_ins", params: { sleep_at: Time.current }
          end
          travel_to 3.minutes.from_now do
            post "/api/v1/clock_ins", params: { sleep_at: Time.current }
          end
        end.to change { ClockIn.count }.by(3)
        expect(json_body.size).to eq 3

        expected_clock_in_ids = ClockIn.where(user: user).order(id: :desc).pluck(:id)
        expect(json_body.map{ |clock_in| clock_in["id"]}).to eq expected_clock_in_ids
      end
    end
  end

  describe "GET #clock_in_by_friend" do
    context "when friend is the receiver" do
      it "returns the sleep records of past week from friend" do
        user = FactoryBot.create(:user)
        friend = FactoryBot.create(:user)

        FactoryBot.create(:clock_in, user: friend, created_at: 8.days.ago, sleep_at: 8.days.ago, wake_up_at: 7.7.days.ago) # sleep 0.3 day
        FactoryBot.create(:clock_in, user: friend, created_at: 4.days.ago, sleep_at: 4.days.ago, wake_up_at: 3.6.days.ago) # sleep 0.4 day
        FactoryBot.create(:clock_in, user: friend, wake_up_at: 8.hours.from_now) # sleep 0.3 day
        FactoryBot.create(:follow, sender: user, receiver: friend)

        login(user)
        get "/api/v1/clock_in_by_friend/#{friend.id}"
        expect(json_body.size).to eq 2

        expected_clock_in_ids = ClockIn
          .where(user_id: friend.id)
          .where("created_at >= ?", 7.days.ago)
          .order(sleep_time_in_second: :desc)
          .pluck(:id)
        expect(json_body.map{ |clock_in| clock_in["id"] }).to eq expected_clock_in_ids
      end
    end
  end
end
