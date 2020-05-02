require 'rails_helper'

feature 'Admin view all CarCategory' do
  scenario 'successfully' do
    carcategory = CarCategory.create!(name: 'Básico', daily_rate: '4.50', 
      car_insurance: '1000', third_part_insurance: '950.50')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user
    
    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_content('Básico')
  end

  scenario 'and view details' do
    carcategory = CarCategory.create!(name: 'A', daily_rate: '4.50', 
                                      car_insurance: '1000', 
                                      third_part_insurance: '950.50')

    manufacturer = Manufacturer.create!(name: 'Fiat')
    
    uno = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer, 
                    motorization: '1.0', fuel_type: 'Flex', car_category: carcategory)

    mobi = CarModel.create!(name: 'Mobi', year: 2020, manufacturer: manufacturer, 
                    motorization: '1.0', fuel_type: 'Flex', car_category: carcategory)
      
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias de carros'
    click_on carcategory.name

    expect(page).to have_css('h1', text: carcategory.name)
    expect(page).to have_css('p', text: "R$ 4,50")
    expect(page).to have_css('p', text: "R$ 1.000,00")
    expect(page).to have_css('p', text: "R$ 950,50")
    expect(page).to have_link('Uno', href: car_model_path(uno))
    expect(page).to have_link('Mobi', href: car_model_path(mobi))
  end

  scenario 'and no car category are created' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_css('h1', text: 'Não há categorias cadastradas')
  end

  scenario 'and return to home page' do
    carcategory = CarCategory.create!(name: 'Básico', daily_rate: '4.50', 
      car_insurance: '1000', third_part_insurance: '950.50')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to car category page' do
    carcategory = CarCategory.create!(name: 'Básico', daily_rate: '4.50', 
      car_insurance: '1000', third_part_insurance: '950.50')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias de carros'
    click_on carcategory.name
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end

  scenario 'and view filtered car model' do
    carcategory = CarCategory.create!(name: 'A', daily_rate: '4.50', 
                                      car_insurance: '1000', 
                                      third_part_insurance: '950.50')

    carcategory_b = CarCategory.create!(name: 'B', daily_rate: '4.50', 
                                      car_insurance: '1000', 
                                      third_part_insurance: '950.50')

    manufacturer = Manufacturer.create!(name: 'Fiat')
    
    uno = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufacturer, 
                    motorization: '1.0', fuel_type: 'Flex', car_category: carcategory)

    argos = CarModel.create!(name: 'Argos', year: 2020, manufacturer: manufacturer, 
                    motorization: '1.0', fuel_type: 'Flex', car_category: carcategory_b)
  
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user
    
    visit root_path
    click_on 'Categorias de carros'
    click_on carcategory.name

    expect(page).to have_link('Uno', href: car_model_path(uno))
    expect(page).not_to have_link('Argos', href: car_model_path(argos))
  end
  
  scenario 'cannot view unless logged in' do
    visit car_categories_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'cannot view unless logged in' do
    CarCategory.create!(name: 'A', daily_rate: '4.50', 
      car_insurance: '1000', 
      third_part_insurance: '950.50')

    visit manufacturer_path(1)

    expect(current_path).to eq(new_user_session_path)
  end
end