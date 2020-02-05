require 'rails_helper'

feature 'Admin edits car category' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    create(:car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'C'
    find('.btn.btn-warning').click
    fill_in 'Nome', with: 'Categoria Y'
    fill_in 'Diária', with: '1050.56'
    fill_in 'Seguro', with: '1023.32'
    fill_in 'Seguro contra terceiros', with: '100'
    click_on 'Enviar'

    expect(page).to have_content('Categoria Y')
    expect(page).to have_content('R$ 1.050,56')
    expect(page).to have_content('R$ 1.023,32')
    expect(page).to have_content('R$ 100,00')
  end

  scenario 'and must be authenticated' do
    visit edit_car_category_path('whatever')

    expect(current_path).to eq(new_user_session_path)
  end
end
