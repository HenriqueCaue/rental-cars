require 'rails_helper'

RSpec.describe Rental, type: :model do
  it 'should generate a code on create' do
    customer = Customer.create!(name: 'Fulano', document: '100.954.020-39', 
                                email: 'test@text.com')

    car_category = CarCategory.create(name: 'A', daily_rate: 100, 
      car_insurance: 10, third_part_insurance: 2000)
    
    rental = Rental.new(start_date:1.day.from_now, end_date: 2.days.from_now, 
            customer: customer, car_category: car_category)
    
    rental.save

    expect(rental.code).not_to be_blank
  end
end
