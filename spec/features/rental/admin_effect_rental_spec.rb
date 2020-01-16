require 'rails_helper'

feature 'Admin effect rental' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '75.980.885/0001-31', address: 
    'R. tal')
    manufacturer = Manufacturer.create(name:'Fiat')
    car_category = CarCategory.create!(name: 'C', daily_rate: 12, car_insurance: 13,
                                        third_party_insurance: 123)
    client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
    rental = Rental.create!(code: 'f092', start_date: Date.current, end_date: 1.day.from_now, 
                  client: client, car_category: car_category, user: user)
    car_model = CarModel.create!(name: 'Uno', year: 2009, motorization: 1.0, fuel_type: 'gasosa',
                                car_category: car_category, manufacturer: manufacturer)
    car = Car.create!(car_model: car_model, license_plate: 'CIC-3301', subsidiary: subsidiary,
                     mileage: '100km', color: 'Vermelho') 
    

    login_as(user, scope: :user)
    visit rentals_path
    fill_in 'Pesquisar', with: 'f092'
    click_on 'Buscar'
    click_on 'f092'
    click_on 'Efetivar locação'
    select 'Uno - CIC-3301 - Vermelho', from: 'Carro'
    click_on 'Efetivar'

    expect(page).to have_content('Locação efetivada com sucesso')
  end
end
