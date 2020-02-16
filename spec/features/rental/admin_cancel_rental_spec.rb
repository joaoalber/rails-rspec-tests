require 'rails_helper'

feature 'Admin cancel rental' do
  scenario 'sucessfully' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    client = create(:client)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)
    rental = create(:rental, client: client, car_category: car_category, user: user,
                             start_date: 3.days.from_now, end_date: 4.days.from_now)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on rental.code.to_s
    click_on 'Cancelar'

    fill_in 'Motivo de cancelamento', with: 'cliente não quer mais'
    click_on 'Enviar'

    expect(page).to have_content('Status: Cancelado')
    expect(page).to have_content('Motivo de cancelamento: cliente não quer mais')
    expect(rental.reload.cancelled?).to eq true
  end

  scenario 'and period should not be in 24 hours to start' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    client = create(:client)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)
    rental = create(:rental, client: client, car_category: car_category, user: user,
                             start_date: 1.day.from_now, end_date: 4.days.from_now)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on rental.code.to_s

    expect(page).to_not have_content('Cancelar')
    expect(rental.reload.cancelled?).to eq false
  end
end
