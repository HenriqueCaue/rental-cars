require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    Manufacturer.create!(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
  end

  scenario 'and name cannot be blank' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    Manufacturer.create!(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and name must be unique' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'cannot view unless logged in' do
    Manufacturer.create!(name: 'Fiat')
    visit edit_manufacturer_path('Fiat')

    expect(current_path).to eq(new_user_session_path)
  end
end
