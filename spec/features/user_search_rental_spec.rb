require 'rails_helper'

feature 'User search rental' do
  scenario 'successfully' do
    customer = Customer.create!(name: 'Fulano', document: '100.954.020-39', 
            email: 'teste@teste.com')

    car_category = CarCategory.create!(name: 'A', daily_rate: 100, 
            car_insurance: 10, third_part_insurance: 2000)

    rental = Rental.create!(start_date:1.day.from_now, end_date: 2.days.from_now, 
            customer: customer, car_category: car_category)

    another_rental = Rental.create!(start_date:1.day.from_now, end_date: 2.days.from_now, 
            customer: customer, car_category: car_category)

    #user = User.create!(email: 'user@teste.com', password: '12345678')
    user = create(:user, :admin)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código', with: rental.code
    click_on 'Buscar'

    expect(page).to have_content(rental.code)
    expect(page).not_to have_content(another_rental.code)
  end

  scenario 'cannot be blank' do
    #user = User.create!(email: 'customer@teste.com', password: '12345678')
    user = create(:user, :admin)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código', with: ''
    click_on 'Buscar'

    expect(page).to have_content("Nenhum resultado encontrado para:")
  end

  scenario 'and code cannot be found' do
    #user = User.create!(email: 'customer@teste.com', password: '12345678')
    user = create(:user, :admin)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    fill_in 'Código', with: 'ABC123'
    click_on 'Buscar'

    expect(page).to have_content('Nenhum resultado encontrado para: ABC123')

  end
end