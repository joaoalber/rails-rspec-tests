require 'rails_helper'

feature 'Search rental' do
  scenario 'by exact code' do
    user = create(:user)
		manufacturer = create(:manufacturer)
		car_category = create(:car_category)
		subsidiary = create(:subsidiary)
		client = create(:client)
		car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    car = create(:car, car_model: car_model, subsidiary: subsidiary)
		rental = create(:rental, client: client, car_category: car_category, user: user)  
		other_rental = create(:rental, client: client, car_category: car_category, user: user)  
									
		login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: "#{rental.code}"
    click_on 'Buscar'

    expect(page).to have_content("#{rental.code}")
    
    expect(page).to_not have_content("#{other_rental.code}")
  end

  scenario 'by partial code' do
    user = create(:user)
		manufacturer = create(:manufacturer)
		car_category = create(:car_category)
		subsidiary = create(:subsidiary)
		client = create(:client)
		car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    car = create(:car, car_model: car_model, subsidiary: subsidiary)
		rental = create(:rental, client: client, car_category: car_category, user: user)  
		other_rental = create(:rental, client: client, car_category: car_category, user: user) 
									
		login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: "#{rental.code.first(3)}"
    click_on 'Buscar'

    expect(page).to have_content("#{rental.code}")

    expect(page).to_not have_content("#{other_rental.code}")
  end

  scenario 'and not exists' do
    user = create(:user)
    
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
