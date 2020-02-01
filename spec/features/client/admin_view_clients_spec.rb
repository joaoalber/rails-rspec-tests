require 'rails_helper'

feature 'Visitor view clients' do
  scenario 'successfully' do
    user = create(:user)
    create(:client, name: 'Gabriel', email: 'gabriel@email.com', cpf: '123.563.212-43')
    create(:client)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'João da Silva'

    expect(page).to have_content('João da Silva')
    expect(page).to have_content('joao@email.com')
    expect(page).to have_content('412.293.102-13')
    expect(page).to_not have_content('Gabriel')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = create(:user)
    create(:client)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'João da Silva'
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
