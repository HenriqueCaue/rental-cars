require 'rails_helper'

feature 'Admin view rentals' do
  scenario 'successfully' do
    customer = Customer.create!(name: 'Fulano', document: '185.972.440-03', 
    email: 'customer@gmail.com')

    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, 
                                      third_part_insurance: 100)

    rental = Rental.create!(start_date: '29/04/2030', end_date: '30/04/2030', 
                            customer: customer, car_category: car_category)

    #user = User.create!(email: 'customer@teste.com', password: '12345678')
    user = create(:user, :admin)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'

    expect(page).to have_content(rental.customer.name)
  end

  scenario 'and view details' do
    customer = Customer.create!(name: 'Fulano', document: '185.972.440-03', 
    email: 'customer@gmail.com')

    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, 
                                      third_part_insurance: 100)

    rental = Rental.create!(start_date: '29/04/2030', end_date: '30/04/2030', 
                            customer: customer, car_category: car_category)
  
    #user = User.create!(email: 'customer@teste.com', password: '12345678')
    user = create(:user, :admin)

    login_as user, scope: :user
    
    visit root_path
    click_on 'Locações'
    click_on 'Fulano'

    expect(page).to have_content("Cliente: #{rental.customer.name}")
    expect(page).to have_content("Categoria: #{rental.car_category.name}")
    expect(page).to have_content('Data de Início: 29/04/2030')
    expect(page).to have_content('Data de Término: 30/04/2030')
  end

  scenario 'and no rentals are created' do
    #user = User.create!(email: 'customer@teste.com', password: '12345678')
    user = create(:user, :admin)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'

    expect(page).to have_content('Nenhuma locação cadastrada')
  end

  scenario 'and return to home page' do
    customer = Customer.create!(name: 'Fulano', document: '185.972.440-03', 
    email: 'customer@gmail.com')

    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, 
                                      third_part_insurance: 100)

    rental = Rental.create!(start_date: '29/04/2030', end_date: '30/04/2030', 
                            customer: customer, car_category: car_category)

    #user = User.create!(email: 'customer@teste.com', password: '12345678')
    user = create(:user, :admin)

    login_as user, scope: :user
    
    visit root_path
    click_on 'Locações'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to rental page' do
    customer = Customer.create!(name: 'Fulano', document: '185.972.440-03', 
    email: 'customer@gmail.com')

    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, 
                                      third_part_insurance: 100)

    rental = Rental.create!(start_date: '29/04/2030', end_date: '30/04/2030', 
                            customer: customer, car_category: car_category)

    #user = User.create!(email: 'customer@teste.com', password: '12345678')
    user = create(:user, :admin)

    login_as user, scope: :user
    
    visit root_path
    click_on 'Locações'
    click_on 'Fulano'
    click_on 'Voltar'

    expect(current_path).to eq rentals_path
  end

  scenario 'cannot view unless logged in' do
    visit root_path

    expect(page).not_to have_link('Locações')
  end

  scenario 'cannot view unless logged in' do
    visit rentals_path

    expect(current_path).to eq(new_user_session_path)
  end
end