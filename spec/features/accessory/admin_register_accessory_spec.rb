require 'rails_helper'

feature 'Admin register accessory' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path

    click_on 'Acessórios'
    click_on 'Registrar novo acessório'
    fill_in 'Nome', with: 'GPS'
    fill_in 'Descrição', with: 'GPS para localização do carro'
    fill_in 'Diária', with: '10.45'
    page.attach_file('Foto', Rails.root + 'spec/fixtures/files/photo.png')
    click_on 'Enviar'

    expect(page).to have_content('GPS')
    expect(page).to have_content('GPS para localização do carro')
    expect(page).to have_content('R$ 10,45')
    expect(page).to have_css('img')
    expect(page).to have_content('Acessório registrado com sucesso')
  end
end
