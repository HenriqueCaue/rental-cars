require 'rails_helper'

feature 'Admin edit car category' do
  scenario 'successfully' do
    CarCategory.create!(name: 'A', daily_rate: '4.50', 
      car_insurance: '1000', third_party_insurance: '950.50')

    visit root_path
    click_on 'Categorias de carros'
    click_on 'A'
    click_on 'Editar'

    fill_in 'Nome', with: 'B'
    fill_in 'Taxa Diária', with: '10'
    fill_in 'Seguro do Carro', with: '2000'
    fill_in 'Seguro Contra Terceiros', with: '1500'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Categoria B')
    expect(page).to have_css('p', text: '10')
    expect(page).to have_css('p', text: '2000')
    expect(page).to have_css('p', text: '1500')
  end

  scenario 'and nothing can be blank' do
    CarCategory.create!(name: 'A', daily_rate: '4.50', 
      car_insurance: '1000', third_party_insurance: '950.50')

    visit root_path
    click_on 'Categorias de carros'
    click_on 'A'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Taxa Diária', with: ''
    fill_in 'Seguro do Carro', with: ''
    fill_in 'Seguro Contra Terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Taxa diária não pode ficar em branco')
    expect(page).to have_content('Seguro do carro não pode ficar em branco')
    expect(page).to have_content('Seguro contra terceiros não pode ficar em branco')
  end

  scenario 'and all must be unique' do
    CarCategory.create!(name: 'A', daily_rate: '4.50', 
      car_insurance: '1000', third_party_insurance: '950.50')

    CarCategory.create!(name: 'B', daily_rate: '4.50', 
      car_insurance: '1000', third_party_insurance: '950.50')

    
    visit root_path
    click_on 'Categorias de carros'
    click_on 'A'
    click_on 'Editar'

    fill_in 'Nome', with: 'B'
    fill_in 'Taxa Diária', with: '4.50'
    fill_in 'Seguro do Carro', with: '1000'
    fill_in 'Seguro Contra Terceiros', with: '950.50'
    click_on 'Enviar'

    expect(page).to have_content('Nome deve ser único')
  end
end