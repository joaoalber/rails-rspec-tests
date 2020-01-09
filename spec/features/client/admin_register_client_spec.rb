require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Joao'
    fill_in 'CPF', with: '1231231231'
    fill_in 'Email', with: 'team@.com'
    click_on 'Enviar'

    expect(page).to have_content('Joao')
    expect(page).to have_content('1231231231')
    expect(page).to have_content('team@.com')
	end

end