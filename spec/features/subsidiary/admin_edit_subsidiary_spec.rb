require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    user = create(:user)
    create(:subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Américas - Filial I'
    find('.btn.btn-warning').click

    fill_in 'Nome', with: 'Concessionária PR'
    fill_in 'CNPJ', with: '97.799.796/0001-26'
    fill_in 'Endereço', with: 'r. dos testes'
    click_on 'Enviar'

    expect(page).to have_content('Concessionária PR')
    expect(page).to have_content('97.799.796/0001-26')
    expect(page).to have_content('r. dos testes')
  end

  scenario 'and must be authenticated' do
    visit edit_subsidiary_path('whatever')

    expect(current_path).to eq(new_user_session_path)
  end
end
