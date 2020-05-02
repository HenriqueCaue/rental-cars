require 'rails_helper'

feature 'admin register valid car category' do
  scenario 'name must be unique' do
    CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '1000', third_part_insurance: '2000')
    
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: 'A'
    fill_in 'Taxa diária', with: '100'
    fill_in 'Seguro do carro', with: '1000'
    fill_in 'Seguro contra terceiros', with: '2000'

    click_on 'Enviar'
    
    expect(page).to have_content('Nome deve ser único')
  end

  scenario 'and nothing can be blank' do
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: ''
    fill_in 'Taxa diária', with: ''
    fill_in 'Seguro do carro', with: ''
    fill_in 'Seguro contra terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Taxa diária não pode ficar em branco')
    expect(page).to have_content('Seguro do carro não pode ficar em branco')
    expect(page).to have_content('Seguro contra terceiros não pode ficar em branco')
  end

  scenario 'values must be greater than 0' do
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: 'A'
    fill_in 'Taxa diária', with: '-100'
    fill_in 'Seguro do carro', with: '-1000'
    fill_in 'Seguro contra terceiros', with: '-2000'

    click_on 'Enviar'
    
    expect(page).to have_content('Taxa diária deve ser maior que 0')
    expect(page).to have_content('Seguro do carro deve ser maior que 0')
    expect(page).to have_content('Seguro contra terceiros deve ser maior que 0')
  end
end
