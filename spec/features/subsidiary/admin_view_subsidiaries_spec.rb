require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    user = create(:user)
    create(:subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Américas - Filial I'

    expect(page).to have_content('Américas - Filial I')
    expect(page).to have_content('17.685.068/0001-54')
    expect(page).to have_content('Av. das Américas, 518')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = create(:user)
    create(:subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Américas - Filial I'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and must be authenticated' do
    visit subsidiaries_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to see the button' do
    visit root_path

    expect(page).to_not have_link('Filiais')
  end

  scenario 'and must be authenticated to view details' do
    visit subsidiary_path('whatever')

    expect(current_path).to eq(new_user_session_path)
  end
end
