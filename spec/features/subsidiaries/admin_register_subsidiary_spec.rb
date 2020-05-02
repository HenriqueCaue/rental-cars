require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'from index page' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar nova filial', href: new_subsidiary_path)
  end

  scenario 'successfully' do
    user = User.create!(email: 'customer@teste.com', password: '12345678')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: '22.880.353/0001-66'
    fill_in 'Endereço', with: 'Rua Joa de Barro'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
    expect(page).to have_css('h1', text: 'São Paulo')
    expect(page).to have_css('p', text: '22.880.353/0001-66')
    expect(page).to have_css('p', text: 'Rua Joa de Barro')

    expect(page).to have_link('Voltar')
  end

  scenario 'cannot view unless logged in' do
    visit new_car_model_path

    expect(current_path).to eq(new_user_session_path)
  end
end
