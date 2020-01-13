require 'rails_helper'

feature 'Admin edits car model' do
  scenario 'successfully' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
    manufacturer = Manufacturer.create!(name: 'Fabricante A')
    Manufacturer.create!(name: 'Fabricante B')
    car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    third_party_insurance: '100.65')
    CarCategory.create!(name: 'Categoria A', daily_rate: '10.33', car_insurance: '30.12', 
    third_party_insurance: '100.63')
    CarModel.create!(name: 'Modelo A', year: '1992', manufacturer: manufacturer, motorization: '2000', 
    car_category: car_category, fuel_type: 'Gasolina')

    visit root_path
    click_on 'Modelos'
    click_on 'Modelo A'
    find(".btn.btn-warning").click
    fill_in 'Nome', with: 'Modelo B'
    fill_in 'Ano', with: '1994'
    select 'Fabricante B', from: 'Fabricante'
    fill_in 'Cavalos', with: '1200'
    select 'Categoria A', from: 'Categoria'
    fill_in 'Combustivel', with: 'Alcool'
    click_on 'Enviar'

    expect(page).to have_content('Modelo B')
    expect(page).to have_content('1994')
    expect(page).to have_content('Fabricante B')
    expect(page).to have_content('1200')
    expect(page).to have_content('Categoria A')
    expect(page).to have_content('Alcool')
  end
end