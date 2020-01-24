require 'rails_helper'

describe Rental do
	describe '#start_date_cannot_be_in_the_past' do
		it 'should not accept dates in the past' do
			user = User.create!(email: "teste@teste.com", password: "123456")
			client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
			car_category = CarCategory.create!(name: 'C', daily_rate: 50, car_insurance: 70, third_party_insurance: 30)
			manufacturer = Manufacturer.create(name:'Fiat')
			subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '75.980.885/0001-31', address: 'R. dos Coqueiros')
			car_model = CarModel.create!(name: 'Uno', year: 2009, motorization: 1.0, fuel_type: 'gasolina', car_category: car_category, manufacturer: manufacturer)
			car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary, mileage: 100, color: 'Vermelho')
			rental = Rental.new(start_date: 2.days.ago, end_date: Date.current, client: client, car_category: car_category, user: user)
			
			rental.valid?

			expect(rental.errors[:start_date]).to include("Data inicial deve ser depois de hoje")
		end
	end

	describe '#end_date_cannot_be_before_start_date' do
		it 'should not accept end date before start date' do
			user = User.create!(email: "teste@teste.com", password: "123456")
			client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
			car_category = CarCategory.create!(name: 'C', daily_rate: 50, car_insurance: 70, third_party_insurance: 30)
			manufacturer = Manufacturer.create(name:'Fiat')
			subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '75.980.885/0001-31', address: 'R. dos Coqueiros')
			car_model = CarModel.create!(name: 'Uno', year: 2009, motorization: 1.0, fuel_type: 'gasolina', car_category: car_category, manufacturer: manufacturer)
			car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary, mileage: 100, color: 'Vermelho')
			rental = Rental.new(start_date: 2.days.ago, end_date: 10.days.ago, client: client, car_category: car_category, user: user)

			rental.valid?

			expect(rental.errors[:end_date]).to include("Data final deve ser depois da data inicial")
		end
	end


end
