require 'rails_helper'

feature 'User register rental' do
  scenario 'successfully' do
    
		user = User.create!(email: "teste@teste.com", password: "123456")
    car_category = CarCategory.create!(name: 'C', daily_rate: 50, car_insurance: 70, third_party_insurance: 30)
    client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
    manufacturer = Manufacturer.create(name:'Fiat')
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '75.980.885/0001-31', address: 'R. dos Coqueiros')
    car_model = CarModel.create!(name: 'Uno', year: 2009, motorization: 1.0, fuel_type: 'gasolina', car_category: car_category, manufacturer: manufacturer)
    car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary, mileage: 100, color: 'Vermelho')
		
    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'

    fill_in 'Data inicial', with: '12/01/2040'
    fill_in 'Data final', with: '13/01/2040'
    select "123456-2 - joao", from: 'Cliente'
    select 'C', from: 'Categoria'
    click_on 'Agendar'
     
    expect(page).to have_content('Locação agendada com sucesso')
    expect(page).to have_content('teste@teste.com')
    expect(page).to have_content('13/01/2040')
    expect(page).to have_content('12/01/2040')
    expect(page).to have_content('teste@teste.com')
    expect(page).to have_content('123456-2')
    expect(page).to have_content(/C/)
		expect(Rental.last.code).to match(/[a-zA-Z0-9]+/)

  end

  scenario 'and start date should not be in the past' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    car_category = CarCategory.create!(name: 'C', daily_rate: 50, car_insurance: 70, third_party_insurance: 30)
    client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
    manufacturer = Manufacturer.create(name:'Fiat')
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '75.980.885/0001-31', address: 'R. dos Coqueiros')
    car_model = CarModel.create!(name: 'Uno', year: 2009, motorization: 1.0, fuel_type: 'gasolina', car_category: car_category, manufacturer: manufacturer)
    car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary, mileage: 100, color: 'Vermelho')

    login_as(user, scope: :user)
    visit new_rental_path
    fill_in 'Data inicial', with: '13/01/2020'
    fill_in 'Data final', with: '20/01/2020'
    click_on 'Agendar'

    expect(page).to have_content('Data inicial deve ser depois de hoje')
  end

  scenario 'and end date should be after start date' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    car_category = CarCategory.create!(name: 'C', daily_rate: 50, car_insurance: 70, third_party_insurance: 30)
    client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
    manufacturer = Manufacturer.create(name:'Fiat')
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '75.980.885/0001-31', address: 'R. dos Coqueiros')
    car_model = CarModel.create!(name: 'Uno', year: 2009, motorization: 1.0, fuel_type: 'gasolina', car_category: car_category, manufacturer: manufacturer)
    car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary, mileage: 100, color: 'Vermelho')

    login_as(user, scope: :user)
    visit new_rental_path
    fill_in 'Data inicial', with: '13/01/2020'
    fill_in 'Data final', with: '10/01/2020' 
    click_on 'Agendar'

    expect(page).to have_content('Data final deve ser depois da data inicial')
  end

  scenario 'and category should have available cars' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    car_category = CarCategory.create!(name: 'C', daily_rate: 50, car_insurance: 70, third_party_insurance: 30)
    manufacturer = Manufacturer.create(name:'Fiat')
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '75.980.885/0001-31', address: 'R. dos Coqueiros')
    
    car_model = CarModel.create!(name: 'Uno', year: 2009, motorization: 1.0, fuel_type: 'gasolina', car_category: car_category, manufacturer: manufacturer)
    car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary, mileage: 100, color: 'Vermelho')
    client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,  client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit new_rental_path

    fill_in 'Data inicial', with: '13/01/2040'
    fill_in 'Data final', with: '20/01/2040'
    select 'C', from: 'Categoria'
    click_on 'Agendar'

    visit new_rental_path

    fill_in 'Data inicial', with: '13/01/2040'
    fill_in 'Data final', with: '20/01/2040'
    select 'C', from: 'Categoria'
    click_on 'Agendar'

    expect(page).to have_content('Não existem carros disponíveis desta categoria')
      
  end

end