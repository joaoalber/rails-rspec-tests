require 'rails_helper'

feature 'Admin register car category' do
  scenario 'successfully' do
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: 'Categoria A'
    fill_in 'Diária', with: '10.5'
    fill_in 'Seguro', with: '200.32'
    fill_in 'Seguro contra terceiros', with: '100.35'
    click_on 'Enviar'

    expect(page).to have_content('Categoria A')
    expect(page).to have_content('10.5')
    expect(page).to have_content('200.32')
    expect(page).to have_content('100.35')
  end

end