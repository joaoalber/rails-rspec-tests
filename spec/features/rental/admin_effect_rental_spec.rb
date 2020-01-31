require 'rails_helper'
feature 'Admin effect rental' do
  scenario 'successfully' do
    user = create(:user)
		manufacturer = create(:manufacturer)
		car_category = create(:car_category)
		subsidiary = create(:subsidiary)
		client = create(:client)
		car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    car = create(:car, car_model: car_model, subsidiary: subsidiary)
    other_car = create(:car, car_model: car_model, subsidiary: subsidiary, license_plate: "TST2313", color: "Azul")
		rental = create(:rental, client: client, car_category: car_category, user: user)                
    

    login_as(user, scope: :user)
    visit rentals_path
    fill_in 'Pesquisar', with: "#{rental.code}"
    click_on 'Buscar'
    click_on "#{rental.code}"
    click_on 'Efetivar locação'
    within("div#car-#{car.id}") do
      click_on 'Efetivar locação'
    end

    expect(page).to have_content('Locação efetivada com sucesso')
  end

  scenario 'and rental status must be in progress' do
    user = create(:user)
		manufacturer = create(:manufacturer)
		car_category = create(:car_category)
		subsidiary = create(:subsidiary)
		client = create(:client)
		car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    car = create(:car, car_model: car_model, subsidiary: subsidiary)
    other_car = create(:car, car_model: car_model, subsidiary: subsidiary, license_plate: "TST2313", color: "Azul")
		rental = create(:rental, client: client, car_category: car_category, user: user)     

    login_as(user, scope: :user)
    visit rentals_path
    click_on "#{rental.code}"
    click_on 'Efetivar locação'
    within("div#car-#{car.id}") do
      click_on 'Efetivar locação'
    end
    visit rentals_path
    click_on "#{rental.code}"
    
    expect(page).to have_content('Locação em progresso')
    expect(page).to_not have_content('Efetivar locação')
  end

  scenario 'and car must be unavailable' do
    user = create(:user)
		manufacturer = create(:manufacturer)
		car_category = create(:car_category)
		subsidiary = create(:subsidiary)
		client = create(:client)
		car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    car = create(:car, car_model: car_model, subsidiary: subsidiary)
    other_car = create(:car, car_model: car_model, subsidiary: subsidiary, license_plate: "TST2313", color: "Azul")
		rental = create(:rental, client: client, car_category: car_category, user: user)     

    login_as(user, scope: :user)
    visit rentals_path
    click_on "#{rental.code}"
    click_on 'Efetivar locação'
    within("div#car-#{car.id}") do
      click_on 'Efetivar locação'
    end

    expect(car.reload).to be_unavailable
  end
end
