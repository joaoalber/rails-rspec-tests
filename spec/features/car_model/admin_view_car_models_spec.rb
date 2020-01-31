require 'rails_helper'

feature 'Visitor view car models' do
  scenario 'successfully' do
    user = create(:user)
    car_category = create(:car_category)
		manufacturer = create(:manufacturer)
    car_model = create(:car_model, manufacturer: manufacturer, car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos'
    click_on 'Uno'
  
    expect(page).to have_content('Uno')
    expect(page).to have_content('2015')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('2.0')
    expect(page).to have_content(/C/)
    expect(page).to have_content('Gasolina')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = create(:user)
    car_category = create(:car_category)
		manufacturer = create(:manufacturer)
    car_model = create(:car_model, manufacturer: manufacturer, car_category: car_category)

    login_as(user, scope: :user)  
    visit root_path
    click_on 'Modelos'
    click_on 'Uno'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and must be authenticated' do
    visit car_models_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to see the button' do
    visit root_path

    expect(page).to_not have_link('Modelos')
  end

  scenario 'and must be authenticated to view details' do
    visit car_model_path(123)

    expect(current_path).to eq(new_user_session_path)
  end

end