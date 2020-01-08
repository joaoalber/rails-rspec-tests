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

  scenario 'and must fill in all fields' do
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro', with: ''
    fill_in 'Seguro contra terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Diária não pode ficar em branco')
    expect(page).to have_content('Seguro não pode ficar em branco')
    expect(page).to have_content('Seguro contra terceiros não pode ficar em branco')
  end

  scenario 'and car category doesnt exists' do
    visit root_path 
    click_on 'Categorias'

    expect(page).to have_content('Nenhuma categoria de carro cadastrada')
  end


end