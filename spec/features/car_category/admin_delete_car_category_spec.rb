require 'rails_helper'

feature 'Admin destroy car category' do
  scenario 'successfully' do
    user = create(:user)
    car_category = create(:car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'C'
    find('.btn.btn-danger').click

    expect(CarCategory.exists?(car_category.id)).to eq(false)
    expect(page).to have_content('Categoria deletada com sucesso')
    expect(page).to_not have_content('Categoria X')
  end

  scenario 'and must be authenticated' do
    page.driver.submit :delete, car_category_path('whatever'), {}

    expect(current_path).to eq(new_user_session_path)
  end
end
