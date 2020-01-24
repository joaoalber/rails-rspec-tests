require 'rails_helper'

feature 'Search rental' do
  scenario 'by exact code' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    car_category = CarCategory.create!(name: 'C', daily_rate: 12, car_insurance: 13, third_party_insurance: 14)
    client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '75.980.885/0001-31', address: 
    'R. dos Coqueiros')
    manufacturer = Manufacturer.create(name:'Fiat')
    car_model = CarModel.create!(name: 'Uno', year: 2009, motorization: 1.0, fuel_type: 'gasosa',
                                car_category: car_category, manufacturer: manufacturer)
    car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary,
                     mileage: 100, color: 'Vermelho')
    other_car = Car.create!(car_model: car_model, license_plate: 'TST2313', subsidiary: subsidiary,
                            mileage: 200, color: 'Azul')
    another_car = Car.create!(car_model: car_model, license_plate: 'TAS2213', subsidiary: subsidiary,
                              mileage: 132, color: 'Cinza')                        
    rental = Rental.create!(start_date: 10.years.from_now, end_date: 11.years.from_now, 
                            client: client, car_category: car_category, user: user)
    other_rental = Rental.create!(start_date: 10.years.from_now, end_date: 11.years.from_now, 
                                    client: client, car_category: car_category, user: user)
									
		login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: "#{rental.code}"
    click_on 'Buscar'

    expect(page).to have_content("#{rental.code}")
    
    expect(page).to_not have_content("#{other_rental.code}")
  end

  scenario 'by partial code' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    car_category = CarCategory.create!(name: 'C', daily_rate: 12, car_insurance: 13, third_party_insurance: 14)
    client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '75.980.885/0001-31', address: 
    'R. dos Coqueiros')
    manufacturer = Manufacturer.create(name:'Fiat')
    car_model = CarModel.create!(name: 'Uno', year: 2009, motorization: 1.0, fuel_type: 'gasosa',
                                car_category: car_category, manufacturer: manufacturer)
    car = Car.create!(car_model: car_model, license_plate: 'CIC3301', subsidiary: subsidiary,
                     mileage: 100, color: 'Vermelho')
    other_car = Car.create!(car_model: car_model, license_plate: 'TST2313', subsidiary: subsidiary,
                            mileage: 200, color: 'Azul')
    another_car = Car.create!(car_model: car_model, license_plate: 'TAS2213', subsidiary: subsidiary,
                              mileage: 132, color: 'Cinza')            
    rental = Rental.create!(start_date: 10.years.from_now, end_date: 11.years.from_now, 
                  client: client, car_category: car_category, user: user)
    other_rental = Rental.create!(start_date: 10.years.from_now, end_date: 11.years.from_now, 
                  client: client, car_category: car_category, user: user)
									
		login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: "#{rental.code.first(3)}"
    click_on 'Buscar'

    expect(page).to have_content("#{rental.code}")

    expect(page).to_not have_content("#{other_rental.code}")
  end

  scenario 'and not exists' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'x234'
    click_on 'Buscar'

    expect(page).to have_content("Foram encontrado(s) 0 resultado(s) para a pesquisa 'x234'")

    click_on 'Voltar'
    expect(current_path).to eq rentals_path
  end

end
