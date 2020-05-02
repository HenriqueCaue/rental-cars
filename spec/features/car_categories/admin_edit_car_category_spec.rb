require 'rails_helper'

feature 'Admin edit car category' do
  scenario 'successfully' do
    CarCategory.create!(name: 'A', daily_rate: '4.50', 
      car_insurance: '1000', third_part_insurance: '950.50')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

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
    expect(page).to have_css('p', text: 'R$ 10,00')
    expect(page).to have_css('p', text: 'R$ 2.000,00')
    expect(page).to have_css('p', text: 'R$ 1.500,00')
  end

  scenario 'and nothing can be blank' do
    CarCategory.create!(name: 'A', daily_rate: '4.50', 
      car_insurance: '1000', third_part_insurance: '950.50')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

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
    expect(page).to have_content('Taxa Diária não pode ficar em branco')
    expect(page).to have_content('Seguro do Carro não pode ficar em branco')
    expect(page).to have_content('Seguro Contra Terceiros não pode ficar em branco')
  end

  scenario 'and all must be unique' do
    CarCategory.create!(name: 'A', daily_rate: '4.50', 
      car_insurance: '1000', third_part_insurance: '950.50')

    CarCategory.create!(name: 'B', daily_rate: '4.50', 
      car_insurance: '1000', third_part_insurance: '950.50')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias de carros'
    click_on 'A'
    click_on 'Editar'

    fill_in 'Nome', with: 'B'
    fill_in 'Taxa Diária', with: '4.50'
    fill_in 'Seguro do Carro', with: '1000'
    fill_in 'Seguro Contra Terceiros', with: '950.50'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and all must be greater than 0' do
    CarCategory.create!(name: 'A', daily_rate: '4.50', 
      car_insurance: '1000', third_part_insurance: '950.50')
    
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user
    
    visit root_path
    click_on 'Categorias de carros'
    click_on 'A'
    click_on 'Editar'

    fill_in 'Nome', with: 'B'
    fill_in 'Taxa Diária', with: '-4.70'
    fill_in 'Seguro do Carro', with: '-2000'
    fill_in 'Seguro Contra Terceiros', with: '0'
    click_on 'Enviar'

    expect(page).to have_content('Taxa Diária deve ser maior que 0')
    expect(page).to have_content('Seguro do Carro deve ser maior que 0')
    expect(page).to have_content('Seguro Contra Terceiros deve ser maior que 0')
  end

  scenario 'cannot view unless logged in' do
    CarCategory.create!(name: 'A', daily_rate: '4.50', 
      car_insurance: '1000', third_part_insurance: '950.50')

    visit edit_car_category_path(1)

    expect(current_path).to eq(new_user_session_path)
  end
end