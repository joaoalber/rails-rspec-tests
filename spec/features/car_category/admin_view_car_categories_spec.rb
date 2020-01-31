require 'rails_helper'

feature 'Visitor view car categories' do
  scenario 'successfully' do
    user = create(:user)
    create(:car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'C'
  
    expect(page).to have_content('C')
    expect(page).to have_content('50')
    expect(page).to have_content('70')
    expect(page).to have_content('20')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = create(:user)
    create(:car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'C'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and must be authenticated' do
    visit car_categories_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to see the button' do
    visit root_path

    expect(page).to_not have_link('Categorias')
  end

  scenario 'and must be authenticated to view details' do
    visit car_category_path('whatever')

    expect(current_path).to eq(new_user_session_path)
  end


end