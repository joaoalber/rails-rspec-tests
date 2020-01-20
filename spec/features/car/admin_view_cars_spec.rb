require 'rails_helper'

feature 'Admin view cars' do
	scenario 'successfully' do
		user = User.create!(email: "teste@teste.com", password: "123456")
		manufacturer = Manufacturer.create!(name: 'Fabricante A')
    car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    																	third_party_insurance: '100.65')
		car_model = CarModel.create!(name: 'Fox', year: '1992', manufacturer: manufacturer, motorization: '2000', 
										car_category: car_category, fuel_type: 'Gasolina')
		subsidiary = Subsidiary.create!(name: 'Av. das Américas', cnpj: '75.980.885/0001-31', address: 'r. dos tamoios')
		car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary,
											mileage: 100, color: 'Vermelho') 


		login_as(user, scope: :user)									
		visit root_path
		click_on 'Carros'
		click_on 'Fox'

		expect(page).to have_content('Fox')
		expect(page).to have_content('CIC3301')
		expect(page).to have_content('Vermelho')
		expect(page).to have_content('Av. das Américas')
		expect(page).to have_content('100')
		expect(page).to have_content('0')


  end

  scenario 'and return to home page' do
    user = User.create!(email: "teste@teste.com", password: "123456")
		manufacturer = Manufacturer.create!(name: 'Fabricante A')
    car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    																	third_party_insurance: '100.65')
		car_model = CarModel.create!(name: 'Fox', year: '1992', manufacturer: manufacturer, motorization: '2000', 
										car_category: car_category, fuel_type: 'Gasolina')
		subsidiary = Subsidiary.create!(name: 'Av. das Américas', cnpj: '75.980.885/0001-31', address: 'r. dos tamoios')
		car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary,
											mileage: 100, color: 'Vermelho')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
		click_on 'Fox'
    click_on 'Voltar'

    expect(current_path).to eq root_path
	end
end