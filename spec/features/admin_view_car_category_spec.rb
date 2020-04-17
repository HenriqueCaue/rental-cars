require 'rails_helper'

feature 'Admin view all CarCategory' do
  scenario 'successfully' do
    carcategory = CarCategory.create!(name: 'Básico', daily_rate: '4.50', 
      car_insurance: '1000', third_party_insurance: '950.50')

    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_content('Básico')
  end

  scenario 'and view details' do
    carcategory = CarCategory.create!(name: 'Básico', daily_rate: '4.50', 
      car_insurance: '1000', third_party_insurance: '950.50')

    visit root_path
    click_on 'Categorias de carros'
    click_on carcategory.name

    expect(page).to have_css('h1', text: carcategory.name)
    expect(page).to have_css('p', text: carcategory.daily_rate)
    expect(page).to have_css('p', text: carcategory.car_insurance)
    expect(page).to have_css('p', text: carcategory.third_party_insurance)
  end

  scenario 'and no car category are created' do
    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_css('h1', text: 'Não há categorias cadastradas')
  end

  scenario 'and return to home page' do
    carcategory = CarCategory.create!(name: 'Básico', daily_rate: '4.50', 
      car_insurance: '1000', third_party_insurance: '950.50')

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to car category page' do
    carcategory = CarCategory.create!(name: 'Básico', daily_rate: '4.50', 
      car_insurance: '1000', third_party_insurance: '950.50')

    visit root_path
    click_on 'Categorias de carros'
    click_on carcategory.name
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end
end