require 'rails_helper'

feature 'Admin destroy car model' do
  scenario 'successfully' do
    user = create(:user)
    car_category = create(:car_category)
    manufacturer = create(:manufacturer)
    car_model = create(:car_model, manufacturer: manufacturer, car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos'
    click_on 'Uno'
    find('.btn.btn-danger').click

    expect(CarModel.exists?(car_model.id)).to eq(false)
    expect(page).to have_content('Modelo de carro deletado com sucesso')
    expect(page).to_not have_content('Modelo A')
  end

  scenario 'and must be authenticated' do
    page.driver.submit :delete, car_model_path('whatever'), {}

    expect(current_path).to eq(new_user_session_path)
  end
end
