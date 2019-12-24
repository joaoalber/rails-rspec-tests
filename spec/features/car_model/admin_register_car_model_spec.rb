require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    CarCategory.create!(name: 'Categoria A', daily_rate: 4.50, car_insurance: 20.30,
    third_party_insurance: 14.30)
    Manufacturer.create!(name: 'Fabricante A')

    visit root_path
    click_on 'Modelos'
    click_on 'Registrar novo modelo'

    fill_in 'Nome', with: 'Modelo A'
    fill_in 'Ano', with: '1992'
    select 'Fabricante A', from: 'Fabricante'
    fill_in 'Cavalos', with: '1200'
    select 'Categoria A', from: 'Categoria'
    fill_in 'Combustivel', with: 'Gasolina'
    click_on 'Enviar'

    expect(page).to have_content('Modelo A')
    expect(page).to have_content('1992')
    expect(page).to have_content('Fabricante A')
    expect(page).to have_content('1200')
    expect(page).to have_content('Categoria A')
    expect(page).to have_content('Gasolina')

  end
end