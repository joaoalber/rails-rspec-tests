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
    create(:car, car_model: car_model, subsidiary: subsidiary, license_plate: 'ASD2311')
    rental = create(:rental, client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit rentals_path
    fill_in 'Pesquisar', with: rental.code.to_s
    click_on 'Buscar'
    click_on rental.code.to_s
    click_on 'Efetivar'
    within("div#car-#{car.id}") do
      click_on 'Efetivar'
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
    create(:car, car_model: car_model, subsidiary: subsidiary, license_plate: 'DRA1231')
    rental = create(:rental, client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit rentals_path
    click_on rental.code.to_s
    click_on 'Efetivar'
    within("div#car-#{car.id}") do
      click_on 'Efetivar'
    end
    visit rentals_path
    click_on rental.code.to_s

    expect(page).to have_content('Em progresso')
    expect(page).to_not have_content('Efetivar')
  end

  scenario 'and car must be unavailable' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    client = create(:client)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    car = create(:car, car_model: car_model, subsidiary: subsidiary)
    create(:car, car_model: car_model, subsidiary: subsidiary, license_plate: 'TST2313')
    rental = create(:rental, client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit rentals_path
    click_on rental.code.to_s
    click_on 'Efetivar'
    within("div#car-#{car.id}") do
      click_on 'Efetivar'
    end

    expect(car.reload).to be_unavailable
  end

  scenario 'and user should add accesory' do
    accessory = create(:accessory, :with_image)
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    client = create(:client)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)
    rental = create(:rental, client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit rentals_path
    click_on rental.code.to_s
    click_on 'Adicionar Acessório'
    select 'GPS', from: 'Acessório'
    click_on 'Adicionar'

    expect(page).to have_content('Acessório adicionado com sucesso')
    expect(page).to have_content(accessory.id)
  end
end
