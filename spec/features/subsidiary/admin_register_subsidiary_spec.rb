require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'General Motors'
    fill_in 'CNPJ', with: '31.480.978/0001-21'
    fill_in 'Endereço', with: 'R. das Palmeiras, 818'
    click_on 'Enviar'

    expect(page).to have_content('General Motors')
    expect(page).to have_content('31.480.978/0001-21')
    expect(page).to have_content('R. das Palmeiras, 818')
    expect(page).to have_content('Filial registrada com sucesso')
  end

  scenario 'and the name shouldnt be duplicated' do
    user = create(:user)
    create(:subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Américas - Filial I'
    fill_in 'CNPJ', with: '97.799.796/0001-26'
    fill_in 'Endereço', with: 'r. tal'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and the cnpj must be valid' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'CNPJ', with: '123456790'
    click_on 'Enviar'

    expect(page).to have_content('CNPJ Inválido')
  end

  scenario 'and subsidiary doesnt exists' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and must be authenticated' do
    visit new_subsidiary_path

    expect(current_path).to eq(new_user_session_path)
  end
end
