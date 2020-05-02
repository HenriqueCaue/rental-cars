require 'rails_helper'

feature 'User register customer' do
  scenario 'from index page' do
    visit root_path
    click_on 'Clientes'

    expect(page).to have_link('Registrar novo cliente', href: new_customer_path)
  end

  scenario 'and view form' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    expect(page).to have_content('Nome')
    expect(page).to have_content('CPF')
    expect(page).to have_content('Email')
  end

  scenario 'successfully' do
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
end