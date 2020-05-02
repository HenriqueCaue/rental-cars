require 'rails_helper'

feature 'Admin view subsidiary' do
  scenario 'successfully' do
    subsidiary = Subsidiary.create!(name: 'São Paulo', cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user
    
    visit root_path
    click_on 'Filiais'

    expect(page).to have_css('h3', text: subsidiary.name)
  end

  scenario 'and view details' do
    subsidiary = Subsidiary.create!(name: 'São Paulo', cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on subsidiary.name

    expect(page).to have_css('h1', text: subsidiary.name)
    expect(page).to have_css('p', text: subsidiary.cnpj)
    expect(page).to have_css('p', text: subsidiary.address)
  end

  scenario 'and no subsidiarys are created' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'

    expect(page).to have_css('h1', text: 'Nenhum fabricante cadastrado')
  end

  scenario 'and return to home page' do
    subsidiary = Subsidiary.create!(name: 'São Paulo', cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiary page' do
    subsidiary = Subsidiary.create!(name: 'São Paulo', cnpj: '22.880.353/0001-66', address: 'Rua Joa de Barro')

    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on subsidiary.name
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end

  scenario 'cannot view unless logged in' do
    visit subsidiaries_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'cannot view unless logged in' do
    visit subsidiary_path(1)

    expect(current_path).to eq(new_user_session_path)
  end
end