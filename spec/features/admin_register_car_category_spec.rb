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

    fill_in 'Nome', with: 'Básico'
    fill_in 'Taxa diária', with: '10'
    fill_in 'Seguro do carro', with: '2000'
    fill_in 'Seguro contra terceiros', with: '1500'
    click_on 'Enviar'

    expect(current_path).to eq car_category_path(CarCategory.last.id)
    expect(page).to have_css('h1', text: 'Básico')
    expect(page).to have_css('p', text: '10')
    expect(page).to have_css('p', text: '2000')
    expect(page).to have_css('p', text: '1500')

    expect(page).to have_link('Voltar')
  end
end