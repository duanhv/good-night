FactoryBot.define do
  factory :clock_in do
  	user { create(:user) }
    sleep_at { Time.current }
  end
end
