require 'rails_helper'

feature 'user view customer' do
  scenario 'succesfully' do
    Customer.create!(name: 'João', document: '820.286.340-65', 
    email: 'customer@email.com')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'

    expect(page).to have_css('h3', text: 'João')
  end

  scenario 'and view details' do
    customer = Customer.create!(name: 'João', document: '820.286.340-65', 
      email: 'customer@email.com')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    click_on customer.name

    expect(page).to have_css('h1', text: customer.name)
    expect(page).to have_css('p', text: customer.document)
    expect(page).to have_css('p', text: customer.email)
  end   

  scenario 'and no customers are created' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'

    expect(page).to have_css('h1', text: 'Não há clientes cadastrados')

  end   

  scenario 'and find return button' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'

    expect(page).to have_link('Voltar', href: root_path)

  end

  scenario 'and find return button' do
    customer = Customer.create!(name: 'João', document: '820.286.340-65', 
    email: 'customer@email.com')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user
      
    visit root_path
    click_on 'Clientes'
    click_on customer.name

    expect(page).to have_link('Voltar', href: customers_path)
  end


  scenario 'and return to home page' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    click_on 'Voltar'

    expect(current_path).to eq root_path

  end

  scenario 'and return to customers page' do
    customer = Customer.create!(name: 'João', document: '820.286.340-65', 
    email: 'customer@email.com')
    
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    click_on customer.name
    click_on 'Voltar'

    expect(current_path).to eq customers_path
  end

  scenario 'cannot view unless logged in' do
    visit customers_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'cannot view unless logged in' do
    visit customer_path(1)

    expect(current_path).to eq(new_user_session_path)
  end

  xscenario 'without rentals' do
    expect(page).to_not have_linh('Iniciar')
  end
end