require 'rails_helper'

feature 'Admin edits car model' do
  scenario 'successfully' do
    user = create(:user)
    car_category = create(:car_category)
    manufacturer = create(:manufacturer)
    create(:car_model, manufacturer: manufacturer, car_category: car_category)
    create(:manufacturer, name: 'Fabricante B')
    create(:car_category, name: 'Categoria A')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos'
    click_on 'Uno'
    find('.btn.btn-warning').click

    fill_in 'Nome', with: 'Modelo B'
    fill_in 'Ano', with: '1994'
    select 'Fabricante B', from: 'Fabricante'
    fill_in 'Cavalos', with: '1200'
    select 'Categoria A', from: 'Categoria'
    fill_in 'Combustivel', with: 'Alcool'

    click_on 'Enviar'

    expect(page).to have_content('Modelo B')
    expect(page).to have_content('1994')
    expect(page).to have_content('Fabricante B')
    expect(page).to have_content('1200')
    expect(page).to have_content('Categoria A')
    expect(page).to have_content('Alcool')
  end

  scenario 'and must be authenticated' do
    visit edit_car_model_path('whatever')

    expect(current_path).to eq(new_user_session_path)
  end
end
