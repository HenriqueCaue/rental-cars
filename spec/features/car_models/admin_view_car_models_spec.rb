require 'rails_helper'

feature 'Admin view car models' do
  scenario 'successfully' do
    # Arrange 
    fiat = Manufacturer.create!(name: 'Fiat')
    ford = Manufacturer.create!(name: 'Ford')
    category = CarCategory.create!(name: 'A', daily_rate: 50, car_insurance: 40, 
                                third_part_insurance: 30)

    CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, 
                      motorization: '1.0', fuel_type: 'Flex', car_category: category)

    CarModel.create!(name: 'Ka', year: 2021, manufacturer: ford, 
                      motorization: '1.0', fuel_type: 'Flex', car_category: category)

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    # Act
    visit root_path
    click_on 'Modelos de Carros'
    
    # Assert
    expect(page).to have_content 'Fiat'
    expect(page).to have_content 'Uno'
    expect(page).to have_content '2020'

    expect(page).to have_content 'Ford'
    expect(page).to have_content 'Ka'
    expect(page).to have_content '2021'
  end

  scenario 'no car models' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Modelos de Carros'

    expect(page).to have_css('h1', text: 'Nenhum modelo cadastrado')
  end

  scenario 'and view details' do
    # Arrange 
    fiat = Manufacturer.create!(name: 'Fiat')
    cat_a = CarCategory.create!(name: 'A', daily_rate: 50, car_insurance: 40, 
                                third_part_insurance: 30)

    cat_e = CarCategory.create!(name: 'E', daily_rate: 250, car_insurance: 100, 
                                third_part_insurance: 100)

    cm = CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat,
                      motorization: '1.0', fuel_type: 'Flex', car_category: cat_a)

    CarModel.create!(name: 'Toro', year: 2020, manufacturer: fiat,
                      motorization: '2.0 Turbo', fuel_type: 'Diesel', car_category: cat_e)
  
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    # Act
    visit root_path
    click_on 'Modelos de Carros'

    within("tr#car-model-#{cm.id}") do
      click_on 'Ver Detalhes'
    end

    #click_on 'Ver Detalhes'
    #find("a#details-#{cm.id}").click() ou click_on "details-#{cm.id}"

    # Assert
    expect(page).to have_content 'Uno'
    expect(page).to have_content 'Fabricante: Fiat'
    expect(page).to have_content 'Ano: 2020'
    expect(page).to have_content 'Motor: 1.0'
    expect(page).to have_content 'Combustível: Flex'
    expect(page).to have_content 'Categoria: A'
    expect(page).to have_content 'Diária: R$ 50,00'

    expect(page).not_to have_content 'Toro'
    expect(page).not_to have_content 'Categoria: E'
    expect(page).not_to have_content 'Combustível: Diesel'
    expect(page).not_to have_content 'Diária: R$ 250,00'
  end

  scenario 'cannot view unless logged in' do
    visit car_models_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'cannot view unless logged in' do
    fiat = Manufacturer.create!(name: 'Fiat')
    cat_a = CarCategory.create!(name: 'A', daily_rate: 50, car_insurance: 40, 
                                third_part_insurance: 30)

    CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat,
                      motorization: '1.0', fuel_type: 'Flex', car_category: cat_a)

    visit car_model_path(1)

    expect(current_path).to eq(new_user_session_path)
  end
end