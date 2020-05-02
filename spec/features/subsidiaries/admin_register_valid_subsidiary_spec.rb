require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and all must be unique' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')
    
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: '22.880.353/0001-66'
    fill_in 'Endereço', with: 'Rua Joa de Barro'

    click_on 'Enviar'
    
    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('CNPJ já está em uso')
    expect(page).to have_content('Endereço já está em uso')
  end

  scenario 'and nothing can be blank' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user
    
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end
end
