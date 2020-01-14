require 'rails_helper'

feature 'Visitor view car models' do
  scenario 'successfully' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    manufacturer = Manufacturer.create!(name: 'Fabricante A')
    car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
                                      third_party_insurance: '100.65')
    CarModel.create!(name: 'Modelo A', year: '1992', manufacturer: manufacturer, motorization: '2000', 
                    car_category: car_category, fuel_type: 'Gasolina')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos'
    click_on 'Modelo A'
  
    expect(page).to have_content('Modelo A')
    expect(page).to have_content('1992')
    expect(page).to have_content('Fabricante A')
    expect(page).to have_content('2000')
    expect(page).to have_content('Categoria X')
    expect(page).to have_content('Gasolina')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    manufacturer = Manufacturer.create!(name: 'Fabricante A')
    car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    third_party_insurance: '100.65')
    CarModel.create!(name: 'Modelo A', year: '1992', manufacturer: manufacturer, motorization: '2000', 
                    car_category: car_category, fuel_type: 'Gasolina')

    login_as(user, scope: :user)  
    visit root_path
    click_on 'Modelos'
    click_on 'Modelo A'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and must be authenticated' do
    visit car_models_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to see the button' do
    visit root_path

    expect(page).to_not have_link('Modelos')
  end

  scenario 'and must be authenticated to view details' do
    visit car_model_path(123)

    expect(current_path).to eq(new_user_session_path)
  end

end