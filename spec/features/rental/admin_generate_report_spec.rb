require 'rails_helper'
feature 'Admin generate report' do
  scenario 'by category and period' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    wrong_car_category = create(:car_category, name: 'A')
    subsidiary = create(:subsidiary)
    client = create(:client)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)
    create(:car, car_model: car_model, subsidiary: subsidiary, license_plate: 'ASD2311')
    create(:rental, client: client, car_category: car_category, user: user)
    create(:rental, start_date: 2.days.from_now, end_date: 30.days.from_now,
                    car_category: car_category, user: user)
    create(:rental, start_date: 2.days.from_now, end_date: 30.days.from_now,
                    car_category: wrong_car_category, user: user)
    create(:rental, start_date: 2.months.from_now, end_date: 3.months.from_now,
                    car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit rentals_path
    click_on 'Relatório'
    select 'C', from: 'Categoria'
    fill_in 'Início', with: 1.day.from_now
    fill_in 'Fim', with: 4.months.from_now
    click_on 'Gerar Relatório'

    expect(page).to have_content('Total de locações durante o período:')
    expect(page).to have_content(/2/)
  end
end
