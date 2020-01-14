require 'rails_helper'

feature 'Visitor view car categories' do
  scenario 'successfully' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
                        third_party_insurance: '100.65')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Categoria X'
  
    expect(page).to have_content('Categoria X')
    expect(page).to have_content('10.44')
    expect(page).to have_content('30.24')
    expect(page).to have_content('100.65')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    third_party_insurance: '100.65')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Categoria X'
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