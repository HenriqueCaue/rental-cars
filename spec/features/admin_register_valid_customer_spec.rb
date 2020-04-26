require 'rails_helper'

feature 'admin register valid customer' do
  scenario 'and all must be unique' do
    customer = Customer.create!(name: 'João', document: '820.286.340-65', email: 'customer@gmail.com')
    
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '820.286.340-65'
    fill_in 'Endereço de email', with: 'customer@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Nome deve ser único')
    expect(page).to have_content('CPF deve ser único')
    expect(page).to have_content('Email deve ser único')
  end

  scenario 'and nothing can be blank' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Endereço de email', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end
end