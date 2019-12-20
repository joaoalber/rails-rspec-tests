require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Concessionária BR', cnpj: '123456', address: 'r. dos tamoios')

    visit root_path
    click_on 'Filiais'
    click_on 'Concessionária BR'
    click_on 'Editar'
    fill_in 'Nome', with: 'Concessionária PR'
    fill_in 'CNPJ', with: '654321'
    fill_in 'Endereço', with: 'r. dos testes'
    click_on 'Enviar'

    expect(page).to have_content('Concessionária PR')
    expect(page).to have_content('654321')
    expect(page).to have_content('r. dos testes')
  end
end