require 'rails_helper'

feature 'Admin register car' do
  scenario 'successfully' do
    manufacturer = Manufacturer.create!(name: 'Fiat')
    
    category = CarCategory.create!(name: 'A', daily_rate: 100,
                                        car_insurance: 100, third_party_insurance: 100)

    car_model = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer, 
                        motorization: '1.0', fuel_type: 'Flex', car_category: category)
    
    subsidiary = Subsidiary.create!(name: 'São Paulo', 
                              cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')
    
    user = User.create!(email: 'customer@teste.com', password: '12345678')

    login_as user, scope: :user

    visit root_path
    click_on 'Frota'
    click_on 'Registrar novo carro'
    select 'Uno', from: 'Modelo do carro'
    fill_in 'Placa', with: 'DVD-9368'
    fill_in 'Cor', with: 'Verde'
    fill_in 'Quilometragem', with: '0'
    select 'São Paulo', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Modelo do carro: Uno')
    expect(page).to have_content('Placa: DVD-9368')
    expect(page).to have_content('Cor: Verde')
    expect(page).to have_content('Quilometragem: 0 km')
    expect(page).to have_content('Filial: São Paulo')
  end

  scenario 'and must be authentication' do
    visit new_car_path

    expect(current_path).to eq(new_user_session_path)
  end
end