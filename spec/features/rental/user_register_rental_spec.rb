require 'rails_helper'

feature 'User register rental' do
  scenario 'successfully' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    create(:client)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'

    fill_in 'Data inicial', with: '12/01/2040'
    fill_in 'Data final', with: '13/01/2040'
    select '412.293.102-13 - João da Silva', from: 'Cliente'
    select 'C', from: 'Categoria'
    click_on 'Agendar'

    expect(page).to have_content('Locação agendada com sucesso')
    expect(page).to have_content('teste@teste.com')
    expect(page).to have_content('13/01/2040')
    expect(page).to have_content('12/01/2040')
    expect(page).to have_content('teste@teste.com')
    expect(page).to have_content('412.293.102-13')
    expect(page).to have_content(/C/)
    expect(Rental.last.code).to match(/[a-zA-Z0-9]+/)
  end

  scenario 'and start date should not be in the past' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    create(:client)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit new_rental_path
    fill_in 'Data inicial', with: '13/01/2020'
    fill_in 'Data final', with: '20/01/2020'
    click_on 'Agendar'

    expect(page).to have_content('Data inicial deve ser depois de hoje')
  end

  scenario 'and end date should be after start date' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    create(:client)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit new_rental_path
    fill_in 'Data inicial', with: '13/01/2020'
    fill_in 'Data final', with: '10/01/2020'
    click_on 'Agendar'

    expect(page).to have_content('Data final deve ser depois da data inicial')
  end

  scenario 'and category should have available cars' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    create(:subsidiary)
    client = create(:client)
    create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:rental, client: client, car_category: car_category, user: user)

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
