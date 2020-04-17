require 'rails_helper'

feature 'Admin view subsidiary' do
  scenario 'successfully' do
    subsidiary = Subsidiary.create!(name: 'São Paulo', cnpj: 'XX.XXX.XXX/XXXX-XX', address: 'Rua Joa de Barro')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_css('h3', text: subsidiary.name)
  end

  scenario 'and view details' do
    subsidiary = Subsidiary.create!(name: 'São Paulo', cnpj: 'XX.XXX.XXX/XXXX-XX', address: 'Rua Joa de Barro')

    visit root_path
    click_on 'Filiais'
    click_on subsidiary.name

    expect(page).to have_css('h1', text: subsidiary.name)
    expect(page).to have_css('p', text: subsidiary.cnpj)
    expect(page).to have_css('p', text: subsidiary.address)
  end

  scenario 'and no subsidiarys are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_css('h1', text: 'Nenhum fabricante cadastrado')
  end

  scenario 'and return to home page' do
    subsidiary = Subsidiary.create!(name: 'São Paulo', cnpj: 'XX.XXX.XXX/XXXX-XX', address: 'Rua Joa de Barro')

    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiary page' do
    subsidiary = Subsidiary.create!(name: 'São Paulo', cnpj: 'XX.XXX.XXX/XXXX-XX', address: 'Rua Joa de Barro')

    visit root_path
    click_on 'Filiais'
    click_on subsidiary.name
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end