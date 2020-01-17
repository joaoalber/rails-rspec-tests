require 'rails_helper'

feature 'Admin edits client' do
	scenario 'sucessfully' do
		user = User.create!(email: "teste@teste.com", password: "123456")
		Client.create!(name: 'Joao', email: 'joao@email.com', cpf: '123.563.212-58')

		login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Joao'
    find(".btn.btn-warning").click

    fill_in 'Nome', with: 'Gabriel'
    fill_in 'Email', with: 'gabriel@email.com'
    fill_in 'CPF', with: '329.201.239-48'
		
    click_on 'Enviar'

    expect(page).to have_content('Gabriel')
    expect(page).to have_content('329.201.239-48')
    expect(page).to have_content('gabriel@email.com')
	end

	scenario 'and must be authenticated' do
    visit edit_client_path('whatever')
    
    expect(current_path).to eq(new_user_session_path)
	end
	
end