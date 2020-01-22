require 'rails_helper'
describe 'Car management' do
	context 'show' do
		it 'renders a json successfully' do
			manufacturer = Manufacturer.create!(name: 'Fabricante A')
    	car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    																	third_party_insurance: '100.65')
			car_model = CarModel.create!(name: 'Fox', year: '1992', manufacturer: manufacturer, motorization: '2000', 
																		car_category: car_category, fuel_type: 'Gasolina')
			subsidiary = Subsidiary.create!(name: 'Av. das Américas', cnpj: '75.980.885/0001-31', address: 'r. dos tamoios')
			car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary, mileage: 100, color: 'Vermelho')
											
			get api_v1_car_path(car)	
			json = JSON.parse(response.body, symbolize_names: true)

			expect(response).to have_http_status(200)
			expect(json[:car_model_id]).to eq(car.car_model.id)
			expect(json[:license_plate]).to eq(car.license_plate)
			expect(json[:color]).to eq(car.color)
	
		end

		it 'shouldnt render a car that not exists' do
			get api_v1_car_path(999)

			expect(response).to have_http_status(404)
		end
	end

	context 'index' do
		it 'should render all cars' do
			manufacturer = Manufacturer.create!(name: 'Fabricante A')
    	car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    																	third_party_insurance: '100.65')
			car_model = CarModel.create!(name: 'Fox', year: '1992', manufacturer: manufacturer, motorization: '2000', 
																		car_category: car_category, fuel_type: 'Gasolina')
			subsidiary = Subsidiary.create!(name: 'Av. das Américas', cnpj: '75.980.885/0001-31', address: 'r. dos tamoios')
			car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary, mileage: 100, color: 'Vermelho')
			other_car = Car.create!(car_model: car_model, license_plate: 'DRA5820', subsidiary: subsidiary, mileage: 100, color: 'Azul')
			another_car = Car.create!(car_model: car_model, license_plate: 'CDV2311', subsidiary: subsidiary, mileage: 100, color: 'Rosa')

			get api_v1_cars_path
			#json = JSON.parse(response.body)
			expect(response).to have_http_status(200)
			expect(response.body).to include "#{other_car.license_plate}" 
			expect(response.body).to include "#{another_car.license_plate}" 
			expect(response.body).to include "#{car.license_plate}" 
			
			
		end
	end
end