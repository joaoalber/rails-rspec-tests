require 'rails_helper'

feature 'Admin edit rental' do
	scenario 'sucessfully' do
		user = User.create!(email: "teste@teste.com", password: "123456")
		car_category = CarCategory.create!(name: 'C', daily_rate: 12, car_insurance: 13,
                                        third_party_insurance: 123)
    client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
    rental = Rental.create!(code: 'f092x123', start_date: Date.current, end_date: 1.day.from_now, 
                  					client: client, car_category: car_category, user: user)

		login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
		click_on 'f092x123'
		find(".btn.btn-warning").click

    fill_in 'Data inicial', with: '13/01/2030'
    fill_in 'Data final', with: '14/01/2030'
    select "123456-2 - joao", from: 'Cliente'
    select 'C', from: 'Categoria'
		click_on 'Agendar'

		expect(page).to have_content('13/01/2030')
		expect(page).to have_content('14/01/2030')
		expect(page).to have_content('123456-2 - joao')
		expect(page).to have_content('C')
		

	end

	scenario 'and must be authenticated' do
    visit edit_rental_path('whatever')
    
    expect(current_path).to eq(new_user_session_path)
  end
end