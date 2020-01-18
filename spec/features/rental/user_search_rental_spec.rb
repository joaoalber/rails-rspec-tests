require 'rails_helper'

feature 'Search rental' do
  scenario 'by exact code' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    car_category = CarCategory.create!(name: 'C', daily_rate: 12, car_insurance: 13, third_party_insurance: 14)
    client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
    Rental.create!(code: 'x234', start_date: 10.years.from_now, end_date: 11.years.from_now, 
                  client: client, car_category: car_category, user: user)
    Rental.create!(code: 'x235', start_date: 10.years.from_now, end_date: 11.years.from_now, 
                  client: client, car_category: car_category, user: user)
    Rental.create!(code: 'f092', start_date: 10.years.from_now, end_date: 11.years.from_now, 
									client: client, car_category: car_category, user: user)
									
		login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'x234'
    click_on 'Buscar'

    expect(page).to have_content('x234')
    expect(page).to have_content('joao')
    expect(page).to have_content('teste@teste.com')
    
    expect(page).to_not have_content('x235')
    expect(page).to_not have_content('f092')
  end

  scenario 'by partial code' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    car_category = CarCategory.create!(name: 'C', daily_rate: 12, car_insurance: 13, third_party_insurance: 14)
    client = Client.create!(name: 'joao', email: 'teste@teste.com', cpf: '123456-2')
    Rental.create!(code: 'x234', start_date: 10.years.from_now, end_date: 11.years.from_now, 
                  client: client, car_category: car_category, user: user)
    Rental.create!(code: 'x235', start_date: 10.years.from_now, end_date: 11.years.from_now, 
                  client: client, car_category: car_category, user: user)
    Rental.create!(code: 'f092', start_date: 10.years.from_now, end_date: 11.years.from_now, 
									client: client, car_category: car_category, user: user)
									
		login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'x2'
    click_on 'Buscar'

    expect(page).to have_content('x234')
    expect(page).to have_content('teste@teste.com')
    expect(page).to have_content('joao')

    expect(page).to have_content('x235')
    expect(page).to have_content('joao')
    expect(page).to have_content('teste@teste.com')

    expect(page).to_not have_content('f092')
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
