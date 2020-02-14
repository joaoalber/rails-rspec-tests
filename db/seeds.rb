# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'teste@teste.com', password: '123456')
car_category = CarCategory.create(name: 'C', daily_rate: 30, car_insurance: 45, third_party_insurance: 50)
client = Client.create(name: 'joao', email: 'joao@email.com', cpf: '123456-2')
manufacturer = Manufacturer.create(name: 'Fiat')
rental = Rental.create(code: 'x234', start_date: Date.current, end_date: 1.day.from_now, 
								client: client, car_category: car_category)
car_model = CarModel.create(name: 'Uno', year: '2002', manufacturer: manufacturer, motorization: '2.0', 
														car_category: car_category, fuel_type: 'Gasolina')
subsidiary = Subsidiary.create(name: 'Concessionária BR', cnpj: '75.980.885/0001-31', address: 'Av. das Américas')
car = Car.create(license_plate: 'DRI-2384', color: 'Vermelho', car_model: car_model, mileage: 50,
						subsidiary: subsidiary)
CarRental.create(price: '100', rental: rental, car: car, initial_mileage: car.mileage, final_mileage: 100)