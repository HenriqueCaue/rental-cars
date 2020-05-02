require 'rails_helper'

feature 'Admin register car category' do
  scenario 'from index page' do
    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_link('Registrar nova categoria', href: new_car_category_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Categorias de carros'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: 'A'
    fill_in 'Taxa Diária', with: '10'
    fill_in 'Seguro do Carro', with: '2000'
    fill_in 'Seguro Contra Terceiros', with: '1500'
    click_on 'Enviar'

    expect(current_path).to eq car_category_path(CarCategory.last.id)
    expect(page).to have_css('h1', text: 'A')
    expect(page).to have_css('p', text: 'R$ 10,00')
    expect(page).to have_css('p', text: 'R$ 2.000,00')
    expect(page).to have_css('p', text: 'R$ 1.500,00')

    expect(page).to have_link('Voltar')
  end
end