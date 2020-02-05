require 'rails_helper'

feature 'Admin view cars' do
  scenario 'successfully' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Uno'

    expect(page).to have_content('Uno')
    expect(page).to have_content('DXC2132')
    expect(page).to have_content('Vermelho')
    expect(page).to have_content('Américas - Filial I')
    expect(page).to have_content('50 Quilômetros')
  end

  scenario 'and return to home page' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Uno'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end
