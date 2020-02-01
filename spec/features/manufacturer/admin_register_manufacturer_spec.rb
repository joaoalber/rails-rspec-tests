require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
    expect(page).to have_content('Fabricante de carro cadastrada com sucesso')
  end

  scenario 'and must fill in all fields' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and the name doesnt exists' do
    user = create(:user)
    create(:manufacturer)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Nome já existente')
  end

  scenario 'and manufacturer doesnt exists' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_content('Nenhuma fabricante cadastrada')
  end

  scenario 'and must be authenticated' do
    visit new_manufacturer_path

    expect(current_path).to eq(new_user_session_path)
  end
end
