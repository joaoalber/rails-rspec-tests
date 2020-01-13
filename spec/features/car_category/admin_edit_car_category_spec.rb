require 'rails_helper'

feature 'Admin edits car category' do
  scenario 'successfully' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
    CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
    third_party_insurance: '100.65')

    visit root_path
    click_on 'Categorias'
    click_on 'Categoria X'
    find(".btn.btn-warning").click
    fill_in 'Nome', with: 'Categoria Y'
    fill_in 'Diária', with: '1050.56'
    fill_in 'Seguro', with: '1023.32'
    fill_in 'Seguro contra terceiros', with: '100'
    click_on 'Enviar'

    expect(page).to have_content('Categoria Y')
    expect(page).to have_content('1050.56')
    expect(page).to have_content('1023.32')
    expect(page).to have_content('100')
  end
end