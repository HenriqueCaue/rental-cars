FactoryBot.define do
  factory :car do
    license_plate { 'DVD-9368' }
    color { 'Verde' }
    car_model
    mileage { 10 }
    subsidiary
  end
end
