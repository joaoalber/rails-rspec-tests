require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'General Motors'
    fill_in 'CNPJ', with: '3367992-123/xx'
    fill_in 'Endereço', with: 'R. das Palmeiras, 818'
    click_on 'Enviar'

    expect(page).to have_content('General Motors')
    expect(page).to have_content('3367992-123/xx')
    expect(page).to have_content('R. das Palmeiras, 818')
  end

end