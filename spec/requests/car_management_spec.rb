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

			get api_v1_cars_path
			
			json = JSON.parse(response.body, symbolize_names: true)

			expect(response).to have_http_status(200)
			expect(json[0][:license_plate]).to eq (car.license_plate)
			expect(json[1][:license_plate]).to eq(other_car.license_plate)
			
		end

		it 'shouldnt render cars if not exists' do
			get api_v1_cars_path

			expect(response).to have_http_status(404)
		end

	end

	context 'create' do
		it 'should return rendered car successfully' do
			
			manufacturer = Manufacturer.create!(name: 'Fabricante A')
    	car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    																	third_party_insurance: '100.65')
			car_model = CarModel.create!(name: 'Fox', year: '1992', manufacturer: manufacturer, motorization: '2000', 
																		car_category: car_category, fuel_type: 'Gasolina')
			subsidiary = Subsidiary.create!(name: 'Av. das Américas', cnpj: '75.980.885/0001-31', address: 'r. dos tamoios')

			post api_v1_cars_path, params: {  car_model_id: car_model.id,
																				license_plate: 'CIC3301',
																				subsidiary_id: subsidiary.id,
																				mileage: 100,
																				color: 'Vermelho'
																			}

			json = JSON.parse(response.body, symbolize_names: true)
			
			expect(response).to have_http_status(201)
			expect(json[:car_model_id]).to eq(car_model.id)
			expect(json[:subsidiary_id]).to eq(subsidiary.id)
			expect(json[:license_plate]).to eq('CIC3301')
			expect(json[:mileage]).to eq(100)
			expect(json[:color]).to eq('Vermelho')

		end

		it 'shouldnt return and render a car with invalid data' do
			post api_v1_cars_path, params: { hiphop: 'batalha' }

			expect(response).to have_http_status(412)
		end

	end

	context 'status' do
		
		it 'should return and render a car modified by status' do

			manufacturer = Manufacturer.create!(name: 'Fabricante A')
    	car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    																	third_party_insurance: '100.65')
			car_model = CarModel.create!(name: 'Fox', year: '1992', manufacturer: manufacturer, motorization: '2000', 
																		car_category: car_category, fuel_type: 'Gasolina')
			subsidiary = Subsidiary.create!(name: 'Av. das Américas', cnpj: '75.980.885/0001-31', address: 'r. dos tamoios')
			car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary, mileage: 100, color: 'Vermelho')

			patch status_api_v1_car_path(car), params: { status: 'unavailable' }

			json = JSON.parse(response.body, symbolize_names: true)

			expect(response).to have_http_status(200)
			expect(json[:status]).to eq('unavailable')

		end

		it 'should render precondition failed if invalid status' do
				
				car_category = CarCategory.create!(name: 'A', daily_rate: 99, car_insurance: 1000,
        																	 third_party_insurance: 1499)
        manufacturer = Manufacturer.create!(name: 'Chevrolet')
        subsidiary = Subsidiary.create!(name: 'Filial1', cnpj:'75.980.885/0001-31', address: 'Rua teste')
				car_model = CarModel.create!(name: 'Celta', year: '2021', motorization: '2.0',fuel_type:'Flex',
					 														manufacturer: manufacturer, car_category: car_category)
        car = Car.create!(license_plate: 'ABC-1234', color: 'Azul', car_model: car_model, mileage: 100, subsidiary: subsidiary, status: 0)

				patch status_api_v1_car_path(car), params: { status: 'banana' }
				
				expect(response.body).to eq("'banana' is not a valid status")
        expect(response).to have_http_status(412)
				
		end

		it 'should return and render a car if not found' do
			patch status_api_v1_car_path(999)

			expect(response).to have_http_status(404)
		end

	end

end