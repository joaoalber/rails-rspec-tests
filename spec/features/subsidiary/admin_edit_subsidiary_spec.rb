require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
    Subsidiary.create!(name: 'Concessionária BR', cnpj: '75.980.885/0001-31', address: 'r. dos tamoios')

    visit root_path
    click_on 'Filiais'
    click_on 'Concessionária BR'
    click_on 'Editar'
    fill_in 'Nome', with: 'Concessionária PR'
    fill_in 'CNPJ', with: '97.799.796/0001-26'
    fill_in 'Endereço', with: 'r. dos testes'
    click_on 'Enviar'

    expect(page).to have_content('Concessionária PR')
    expect(page).to have_content('97.799.796/0001-26')
    expect(page).to have_content('r. dos testes')
  end
end