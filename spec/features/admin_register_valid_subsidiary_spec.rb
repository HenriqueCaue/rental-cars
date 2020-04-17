require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and name must be unique' do
    Subsidiary.create!(name: 'São Paulo', cnpj: 'XX.XXX.XXX/XXXX-XX', address: 'Rua Joa de Barro')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: 'XX.XXX.XXX/XXXX-XX'
    fill_in 'Endereço', with: 'Rua Joa de Barro'

    click_on 'Enviar'
    
    expect(page).to have_content('Nome deve ser único')
  end

  scenario 'and cnpj must be unique' do
    Subsidiary.create!(name: 'São Paulo', cnpj: 'XX.XXX.XXX/XXXX-XX', address: 'Rua Joa de Barro')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: 'XX.XXX.XXX/XXXX-XX'
    fill_in 'Endereço', with: 'Rua Joa de Barro'

    click_on 'Enviar'
    
    expect(page).to have_content('CNPJ deve ser único')
  end

  scenario 'and address must be unique' do
    Subsidiary.create!(name: 'São Paulo', cnpj: 'XX.XXX.XXX/XXXX-XX', address: 'Rua Joa de Barro')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: 'XX.XXX.XXX/XXXX-XX'
    fill_in 'Endereço', with: 'Rua Joa de Barro'

    click_on 'Enviar'
    
    expect(page).to have_content('Endereço deve ser único')
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'CNPJ', with: ''
    click_on 'Enviar'

    expect(page).to have_content('CNPJ não pode ficar em branco')
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Endereço não pode ficar em branco')
  end
end
