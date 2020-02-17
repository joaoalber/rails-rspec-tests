require 'rails_helper'

feature 'Admin view car rental' do
  scenario 'successfully' do
    user = create(:user, email: 'tast@email.com')
    car_rental = create(:car_rental)

    login_as(user, scope: :user)
    visit car_rental_path(car_rental)

    expect(page).to have_content('30')
    expect(page).to have_content(car_rental.car.car_model.name)
    expect(page).to have_content(car_rental.car.license_plate)
  end
end
