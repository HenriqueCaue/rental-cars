require 'rails_helper'

feature 'User start rental' do
  scenario 'succesfully' do
    manufacturer = Manufacturer.create!(name: 'Fiat')

    customer = Customer.create!(name: 'Fulano Sicrano', document: '100.954.020-39', 
      email: 'test@test.com')

    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, 
                                        third_part_insurance: 100)
                                  
    car_model = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer,
                motorization: '1.0', fuel_type: 'Flex', car_category: car_category)

    subsidiary = Subsidiary.create!(name: 'São Paulo', 
                cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')
                    
    car = Car.create!(license_plate: 'DVD-9368', color: 'Verde', car_model: car_model, 
          mileage: '0', subsidiary: subsidiary)
    
    rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.day.from_now, 
                            customer: customer, car_category: car_category)

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit search_rentals_path(q: rental.code)
    click_on 'Iniciar'
    select car.license_plate, from: 'Carro'
    click_on 'Confirmar locação'

    expect(page).to have_content(I18n.l(Time.zone.now, format: :long))
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content('Em progresso')
    expect(page).to have_content(user.email)
  end

  scenario 'from customer page' do
    manufacturer = Manufacturer.create!(name: 'Fiat')

    customer = Customer.create!(name: 'Fulano Sicrano', document: '100.954.020-39', 
      email: 'test@test.com')

    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, 
                                        third_part_insurance: 100)
                                  
    car_model = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer,
                motorization: '1.0', fuel_type: 'Flex', car_category: car_category)

    subsidiary = Subsidiary.create!(name: 'São Paulo', 
                cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')
                    
    car = Car.create!(license_plate: 'DVD-9368', color: 'Verde', car_model: car_model, 
          mileage: '0', subsidiary: subsidiary)
    
    rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.day.from_now, 
                            customer: customer, car_category: car_category)

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit customer_path(customer)
    click_on 'Iniciar'
    select car.license_plate, from: 'Carro'
    click_on 'Confirmar locação'

    expect(page).to have_content(I18n.l(Time.zone.now, format: :long))
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content('Em progresso')
    expect(page).to have_content(user.email)
  end
end