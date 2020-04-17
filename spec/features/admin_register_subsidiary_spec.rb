require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'from index page' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar nova filial', href: new_subsidiary_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: 'XX.XXX.XXX/XXXX-XX'
    fill_in 'Endereço', with: 'Rua Joa de Barro'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
    expect(page).to have_css('h1', text: 'São Paulo')
    expect(page).to have_css('p', text: 'XX.XXX.XXX/XXXX-XX')
    expect(page).to have_css('p', text: 'Rua Joa de Barro')

    expect(page).to have_link('Voltar')
  end
end
