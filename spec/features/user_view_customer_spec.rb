require 'rails_helper'

feature 'user view customer' do
  scenario 'succesfully' do
    Customer.create!(name: 'João', document: '820.286.340-65', 
    email: 'customer@email.com')

    visit root_path
    click_on 'Clientes'

    expect(page).to have_css('h3', text: 'João')
  end

  scenario 'and view details' do
    customer = Customer.create!(name: 'João', document: '820.286.340-65', 
      email: 'customer@email.com')

    visit root_path
    click_on 'Clientes'
    click_on customer.name

    expect(page).to have_css('h1', text: customer.name)
    expect(page).to have_css('p', text: customer.document)
    expect(page).to have_css('p', text: customer.email)
  end   

  scenario 'and no customers are created' do
    visit root_path
    click_on 'Clientes'

    expect(page).to have_css('h1', text: 'Não há clientes cadastrados')

  end   

  scenario 'and find return button' do
    visit root_path
    click_on 'Clientes'

    expect(page).to have_link('Voltar', href: root_path)

  end

  scenario 'and find return button' do
    customer = Customer.create!(name: 'João', document: '820.286.340-65', 
    email: 'customer@email.com')
      
    visit root_path
    click_on 'Clientes'
    click_on customer.name

    expect(page).to have_link('Voltar', href: customers_path)

  end


  scenario 'and return to home page' do
    visit root_path
    click_on 'Clientes'
    click_on 'Voltar'

    expect(current_path).to eq root_path

  end

  scenario 'and return to customers page' do
    customer = Customer.create!(name: 'João', document: '820.286.340-65', 
    email: 'customer@email.com')
    
    visit root_path
    click_on 'Clientes'
    click_on customer.name
    click_on 'Voltar'

    expect(current_path).to eq customers_path

  end
end