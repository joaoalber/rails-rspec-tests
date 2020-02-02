require 'rails_helper'

feature 'Admin edit client' do
  scenario 'sucessfully' do
    user = create(:user)
    create(:client)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'João da Silva'
    find('.btn.btn-warning').click

    fill_in 'Nome', with: 'Gabriel'
    fill_in 'E-mail', with: 'gabriel@email.com'
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
