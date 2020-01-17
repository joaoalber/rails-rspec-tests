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

end