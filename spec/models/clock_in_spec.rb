require "rails_helper"

RSpec.describe ClockIn, type: :model do
  describe "#validate - ensure_valid_wake_up_at" do
    context "when create new ClockIn" do
      it "does not update sleep_time_in_second" do
        clockIn = FactoryBot.create(:clock_in, sleep_at: Time.current)
        expect(clockIn.reload.sleep_time_in_second).to be_nil
      end
    end

    context "when update invalid wake_up_at" do
      it "does not update sleep_time_in_second" do
        clockIn = FactoryBot.create(:clock_in, sleep_at: Time.current)
        travel_to 1.hours.ago do
          clockIn.update(wake_up_at: Time.current)
          expect(clockIn.reload.sleep_time_in_second).to be_nil
        end
      end
    end

    context "when update valid wake_up_at" do
      it "updates sleep_time_in_second" do
        clockIn = FactoryBot.create(:clock_in, sleep_at: Time.current)
        travel_to 6.hours.from_now do
          clockIn.update(wake_up_at: Time.current)
          expect(clockIn.reload.sleep_time_in_second).to be_between(5*60*60, 7*60*60)
        end
      end
    end
  end
end
