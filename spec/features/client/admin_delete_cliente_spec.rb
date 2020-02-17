require 'rails_helper'

feature 'Admin destroy client' do
  scenario 'successfully' do
    user = create(:user)
    client = create(:client)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'João da Silva'
    find('.btn.btn-danger').click

    expect(Client.exists?(client.id)).to eq(false)
    expect(page).to have_content('Cliente deletado com sucesso')
    expect(page).to_not have_content('João da Silva')
  end

  scenario 'and must be authenticated' do
    page.driver.submit :delete, client_path(2), {}

    expect(current_path).to eq(new_user_session_path)
  end
end
