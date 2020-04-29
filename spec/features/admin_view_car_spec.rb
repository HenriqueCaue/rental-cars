require 'rails_helper'

feature 'Admin view car' do
  scenario 'successfully' do
    manufacturer = Manufacturer.create!(name: 'Fiat')
    
    category = CarCategory.create!(name: 'A', daily_rate: 100,
                                        car_insurance: 100, third_party_insurance: 100)

    car_model = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer, 
      motorization: '1.0', fuel_type: 'Flex', car_category: category)

    subsidiary = Subsidiary.create!(name: 'São Paulo', 
                        cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    car = Car.create!(license_plate: 'DVD-9368', color: 'Verde', car_model: car_model, 
                      mileage: '0', subsidiary: subsidiary)

    user = User.create!(email: 'customer@teste.com', password: '12345678')

    login_as user, scope: :user

    visit root_path
    click_on 'Frota'

    expect(page).to have_css('h3', text: car.car_model.name)
  end

  scenario 'and view details' do
    manufacturer = Manufacturer.create!(name: 'Fiat')
    
    category = CarCategory.create!(name: 'A', daily_rate: 100,
                                        car_insurance: 100, third_party_insurance: 100)

    car_model = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer, 
      motorization: '1.0', fuel_type: 'Flex', car_category: category)

    subsidiary = Subsidiary.create!(name: 'São Paulo', 
                        cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    car = Car.create!(license_plate: 'DVD-9368', color: 'Verde', car_model: car_model, 
                      mileage: '0', subsidiary: subsidiary)

    user = User.create!(email: 'customer@teste.com', password: '12345678')

    login_as user, scope: :user

    visit root_path
    click_on 'Frota'
    click_on 'Uno'

    expect(page).to have_content('Modelo do carro: Uno')
    expect(page).to have_content('Placa: DVD-9368')
    expect(page).to have_content('Cor: Verde')
    expect(page).to have_content('Quilometragem: 0 km')
    expect(page).to have_content('Filial: São Paulo')
  end

  scenario 'and no cars are created' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')

    login_as user, scope: :user
    visit root_path
    click_on 'Frota'

    expect(page).to have_content('Nenhum carro cadastrado')
  end

  scenario 'and return to index' do
    manufacturer = Manufacturer.create!(name: 'Fiat')
    
    category = CarCategory.create!(name: 'A', daily_rate: 100,
                                        car_insurance: 100, third_party_insurance: 100)

    car_model = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer, 
      motorization: '1.0', fuel_type: 'Flex', car_category: category)

    subsidiary = Subsidiary.create!(name: 'São Paulo', 
                        cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    car = Car.create!(license_plate: 'DVD-9368', color: 'Verde', car_model: car_model, 
                      mileage: '0', subsidiary: subsidiary)

    user = User.create!(email: 'customer@teste.com', password: '12345678')

    login_as user, scope: :user

    visit root_path
    click_on 'Frota'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and view details' do
    manufacturer = Manufacturer.create!(name: 'Fiat')
    
    category = CarCategory.create!(name: 'A', daily_rate: 100,
                                        car_insurance: 100, third_party_insurance: 100)

    car_model = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer, 
      motorization: '1.0', fuel_type: 'Flex', car_category: category)

    subsidiary = Subsidiary.create!(name: 'São Paulo', 
                        cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    car = Car.create!(license_plate: 'DVD-9368', color: 'Verde', car_model: car_model, 
                      mileage: '0', subsidiary: subsidiary)

    user = User.create!(email: 'customer@teste.com', password: '12345678')

    login_as user, scope: :user

    visit root_path
    click_on 'Frota'
    click_on 'Uno'
    click_on 'Voltar'

    expect(current_path).to eq cars_path
  end

  scenario 'cannot view unless logged in' do
    visit root_path

    expect(page).not_to have_link('Frota')
  end

  scenario 'cannot view unless logged in' do
    visit cars_path

    expect(current_path).to eq(new_user_session_path)
  end
end