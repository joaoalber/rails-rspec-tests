require 'rails_helper'

feature 'Admin edit rental' do
  scenario 'sucessfully' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    client = create(:client)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)
    rental = create(:rental, client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on rental.code.to_s
    find('.btn.btn-warning').click

    fill_in 'Data inicial', with: '13/01/2030'
    fill_in 'Data final', with: '14/01/2030'
    select '412.293.102-13 - João da Silva', from: 'Cliente'
    select 'C', from: 'Categoria'
    click_on 'Agendar'

    expect(page).to have_content('13/01/2030')
    expect(page).to have_content('14/01/2030')
    expect(page).to have_content('412.293.102-13 - João da Silva')
    expect(page).to have_content(/C/)
  end

  scenario 'and must be authenticated' do
    visit edit_rental_path('whatever')

    expect(current_path).to eq(new_user_session_path)
  end
end
