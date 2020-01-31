require 'rails_helper'

feature 'Admin register client' do
  scenario 'successfully' do
    user = create(:user)
    
    login_as(user, scope: :user)
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
    expect(page).to have_content('Cliente cadastrado com sucesso')
  end
  
  scenario 'and must be authenticated' do
    visit new_client_path
    
    expect(current_path).to eq(new_user_session_path)
  end

end