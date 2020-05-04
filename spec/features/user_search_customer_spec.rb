require 'rails_helper'

feature 'User search customer' do
  scenario 'by exact name' do
    user = User.create!(email: 'email@test.com', password: '123456789')

    customer = Customer.create!(name: 'Fulano Sicrano', document: '100.954.020-39', 
                                email: 'test@test.com')


    another_customer = Customer.create!(name: 'João da Silva', 
                                        document: '581.280.655-13', 
                                        email: 'test@email.com')

    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: customer.name
    click_on 'Buscar'

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content(customer.email)
    expect(page).not_to have_content(another_customer.name)
    expect(page).not_to have_content(another_customer.email)
    expect(page).not_to have_content(another_customer.document)
  end
end