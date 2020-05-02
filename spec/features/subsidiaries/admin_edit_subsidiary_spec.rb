require 'rails_helper'

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'São Paulo', 
        cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'
    click_on 'Editar'

    fill_in 'Nome', with: 'Rio de Janeiro'
    fill_in 'CNPJ', with: '65.150.743/0001-93'
    fill_in 'Endereço', with: 'Rua ABC'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Rio de Janeiro')
    expect(page).to have_css('p', text: '65.150.743/0001-93')
    expect(page).to have_css('p', text: 'Rua ABC')
  end

  scenario 'and nothing can be blank' do
    Subsidiary.create!(name: 'São Paulo', 
        cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  scenario 'and all must be unique' do
    Subsidiary.create!(name: 'São Paulo', 
        cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    Subsidiary.create!(name: 'Salvador', 
        cnpj: '24.715.285/0001-05', address: 'Rua Estrada Avenida')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'
    click_on 'Editar'

    fill_in 'Nome', with: 'Salvador'
    fill_in 'CNPJ', with: '24.715.285/0001-05'
    fill_in 'Endereço', with: 'Rua Estrada Avenida'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('CNPJ já está em uso')
    expect(page).to have_content('Endereço já está em uso')
  end

  scenario 'cannot view unless logged in' do
    visit edit_subsidiary_path(1)

    expect(current_path).to eq(new_user_session_path)
  end
end