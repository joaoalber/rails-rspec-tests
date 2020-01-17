require 'rails_helper'

feature 'User register rental' do
  scenario 'successfully' do
    
		user = User.create!(email: "teste@teste.com", password: "123456")
    car_category = CarCategory.create!(name: 'C', daily_rate: 12, car_insurance: 13, third_party_insurance: 14)
		client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
		
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
end