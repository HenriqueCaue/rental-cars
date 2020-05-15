require 'rails_helper'

feature 'Admin register rental' do
  scenario 'successfully' do
    customer = Customer.create!(name: 'Fulano Sicrano', document: '185.972.440-03', 
                      email: 'customer@gmail.com')
                    
    car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, 
                                        third_part_insurance: 100)

    #user = User.create!(email: 'customer@teste.com', password: '12345678')

    user = create(:user, :admin)

    mail = double('RentalsMailer')
    allow(RentalsMailer).to receive(:scheduled).and_return(mail)
    allow(mail).to receive(:deliver_now)
    #spy = ('RentalsMailer')
    #stub_const('RentalsMailer', spy)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    click_on 'Registrar nova locação'
    fill_in 'Data de Início', with: '27/04/2030'
    fill_in 'Data de Término', with: '29/04/2030'
    select customer.name, from: 'Cliente'
    select car_category.name, from: 'Categoria'
    #expect { click_on 'Enviar' }.to change { ActionMailer::Base.deliveries.count }
    click_on 'Enviar'
    
    expect(RentalsMailer).to have_received(:scheduled)
    expect(page).to have_content('Data de Início: 27/04/2030')
    expect(page).to have_content('Data de Término: 29/04/2030')
    expect(page).to have_content("Cliente: #{customer.name}")
    expect(page).to have_content("Categoria: #{car_category.name}")
  end

  xscenario 'and must fill in all fields' do
    
  end

  scenario 'and must be authentication' do
    visit new_rental_path

    expect(current_path).to eq(new_user_session_path)
  end
end