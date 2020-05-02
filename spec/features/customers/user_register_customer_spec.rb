require 'rails_helper'

feature 'User register customer' do
  scenario 'from index page' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'

    expect(page).to have_link('Registrar novo cliente', href: new_customer_path)
  end

  scenario 'and view form' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    expect(page).to have_content('Nome')
    expect(page).to have_content('CPF')
    expect(page).to have_content('Email')
  end

  scenario 'successfully' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '820.286.340-65'
    fill_in 'Email', with: 'customer@gmail.com'
    click_on 'Enviar'

    expect(current_path).to eq customer_path(Customer.last.id)
    expect(page).to have_css('h1', text: 'João')
    expect(page).to have_css('p', text: '820.286.340-65')
    expect(page).to have_css('p', text: 'customer@gmail.com')

    expect(page).to have_link('Voltar')
  end

  scenario 'cannot view unless logged in' do
    visit new_customer_path

    expect(current_path).to eq(new_user_session_path)
  end
end