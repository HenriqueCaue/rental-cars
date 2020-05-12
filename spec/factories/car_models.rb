FactoryBot.define do
  factory :car_model do
    name { 'Uno' }
    year { 2020 }
    manufacturer
    motorization { '1.0' }
    fuel_type { 'Flex' }
    car_category
  end
end
