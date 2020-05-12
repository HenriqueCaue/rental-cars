FactoryBot.define do
  factory :rental do
    start_date { 1.day.from_now }
    end_date { 2.day.from_now }
    customer
    car_category
  end
end