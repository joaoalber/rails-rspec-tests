require 'rails_helper'

feature 'Admin register car' do
	scenario 'sucessfully' do
		user = User.create!(email: "teste@teste.com", password: "123456")
		manufacturer = Manufacturer.create!(name: 'Fabricante A')
    car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    																	third_party_insurance: '100.65')
		CarModel.create!(name: 'Fox', year: '1992', manufacturer: manufacturer, motorization: '2000', 
										car_category: car_category, fuel_type: 'Gasolina')
		Subsidiary.create!(name: 'Av. das Américas', cnpj: '75.980.885/0001-31', address: 'r. dos tamoios')

		login_as(user, :scope => :user)
		visit root_path
		click_on 'Carros'
		click_on 'Registrar novo carro'

		fill_in 'Placa', with: 'CIC3301'
		fill_in 'Cor', with: 'Vermelho'
		select 'Fox', from: 'Modelo'
		fill_in 'Quilometragem', with: '15'
		select 'Av. das Américas', from: 'Filial'
		fill_in 'Status', with: '0'
		click_on 'Enviar'

		expect(page).to have_content('CIC3301')
		expect(page).to have_content('Vermelho')
		expect(page).to have_content('Fox')
		expect(page).to have_content('15')
		expect(page).to have_content('Av. das Américas')
		expect(page).to have_content('0')

	end

	scenario 'and must be valid' do
		user = User.create!(email: "teste@teste.com", password: "123456")
	
		login_as(user, :scope => :user)
		visit new_car_path

		click_on 'Enviar'

		expect(page).to have_content('Placa não pode ficar em branco')
		expect(page).to have_content('Cor não pode ficar em branco')
		expect(page).to have_content('Modelo não pode ficar em branco')
		expect(page).to have_content('Quilometragem não pode ficar em branco')
		expect(page).to have_content('Filial não pode ficar em branco')
		expect(page).to have_content('Status não pode ficar em branco')
	end

	scenario 'and mileage should be greater than 0' do
		user = User.create!(email: "teste@teste.com", password: "123456")
	
		login_as(user, :scope => :user)
		visit new_car_path

		fill_in 'Quilometragem', with: '0'
		click_on 'Enviar'

		expect(page).to have_content('Quilometragem deve ser superior a 0')
	end

	scenario 'and license_plate should be unique' do
		user = User.create!(email: "teste@teste.com", password: "123456")
		car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    																	third_party_insurance: '100.65')
		manufacturer = Manufacturer.create!(name: 'Fabricante A')
		car_model = CarModel.create!(name: 'Fox', year: '1992', manufacturer: manufacturer, motorization: '2000', 
										car_category: car_category, fuel_type: 'Gasolina')
		subsidiary = Subsidiary.create!(name: 'Av. das Américas', cnpj: '75.980.885/0001-31', address: 'r. dos tamoios')
		car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary,
											 mileage: 100, color: 'Vermelho', status: '0') 
		
		login_as(user, :scope => :user)
		visit new_car_path

		fill_in 'Placa', with: 'CIC3301'
		click_on 'Enviar'

		expect(page).to have_content('Placa já existente')

	end

end