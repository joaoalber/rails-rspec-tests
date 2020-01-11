require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
    Manufacturer.create!(name: 'Fiat')
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
  end
end