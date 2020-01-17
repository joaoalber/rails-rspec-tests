require 'rails_helper'

feature 'Visitor view clients' do
  scenario 'successfully' do
    user = User.create!(email: "teste@teste.com", password: "123456")
		Client.create!(name: 'Joao', email: 'joao@email.com', cpf: '123.563.212-58')
		Client.create!(name: 'Gabriel', email: 'gabriel@email.com', cpf: '123.563.212-43')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Joao'
  
    expect(page).to have_content('Joao')
    expect(page).to have_content('joao@email.com')
		expect(page).to have_content('123.563.212-58')
		expect(page).to_not have_content('Gabriel')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    Client.create!(name: 'Joao', email: 'joao@email.com', cpf: '123.563.212-58')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Joao'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and must be authenticated' do
    visit clients_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to see the button' do
    visit root_path

    expect(page).to_not have_link('Clientes')
  end

  scenario 'and must be authenticated to view details' do
    visit client_path('whatever')

    expect(current_path).to eq(new_user_session_path)
  end
  
end