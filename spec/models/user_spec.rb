require "rails_helper"

RSpec.describe User, type: :model do
  describe "#is_friend?" do
    context "when friend is not the sender and the receiver" do
      it "returns false" do
        user = FactoryBot.create(:user)
        friend = FactoryBot.create(:user)
        expect(user.is_friend?(friend.id)).to be_falsy
      end
    end

    context "when friend is the sender but not the receiver" do
      it "returns true" do
        user = FactoryBot.create(:user)
        friend = FactoryBot.create(:user)
        FactoryBot.create(:follow, sender: friend, receiver: user)
        expect(user.is_friend?(friend.id)).to be_truthy
      end
    end

    context "when friend is the receiver but not the sender" do
      it "returns true" do
        user = FactoryBot.create(:user)
        friend = FactoryBot.create(:user)
        FactoryBot.create(:follow, sender: user, receiver: friend)
        expect(user.is_friend?(friend.id)).to be_truthy
      end
    end

    context "when friend is both the sender and the receiver" do
      it "returns true" do
        user = FactoryBot.create(:user)
        friend = FactoryBot.create(:user)
        FactoryBot.create(:follow, sender: user, receiver: friend)
        FactoryBot.create(:follow, sender: friend, receiver: user)
        expect(user.is_friend?(friend.id)).to be_truthy
      end
    end
  end
end
