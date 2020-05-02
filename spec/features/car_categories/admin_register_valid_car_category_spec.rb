require 'rails_helper'

feature 'admin register valid car category' do
  scenario 'name must be unique' do
    CarCategory.create!(name: 'A', daily_rate: '100', car_insurance: '1000', third_part_insurance: '2000')
    
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: 'A'
    fill_in 'Taxa Diária', with: '100'
    fill_in 'Seguro do Carro', with: '1000'
    fill_in 'Seguro Contra Terceiros', with: '2000'

    click_on 'Enviar'
    
    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and nothing can be blank' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Registrar nova categoria'

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

  scenario 'values must be greater than 0' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user
    
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: 'A'
    fill_in 'Taxa Diária', with: '-100'
    fill_in 'Seguro do Carro', with: '-1000'
    fill_in 'Seguro Contra Terceiros', with: '-2000'

    click_on 'Enviar'
    
    expect(page).to have_content('Taxa Diária deve ser maior que 0')
    expect(page).to have_content('Seguro do Carro deve ser maior que 0')
    expect(page).to have_content('Seguro Contra Terceiros deve ser maior que 0')
  end
end
