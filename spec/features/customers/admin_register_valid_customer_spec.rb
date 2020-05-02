require 'rails_helper'

feature 'admin register valid customer' do
  scenario 'and all must be unique' do
    customer = Customer.create!(name: 'João', document: '820.286.340-65', email: 'customer@gmail.com')
    
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '820.286.340-65'
    fill_in 'Email', with: 'customer@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('CPF já está em uso')
    expect(page).to have_content('Email já está em uso')
  end

  scenario 'and nothing can be blank' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user
    
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end
end