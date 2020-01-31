require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    user = create(:user)
    create(:car_category)
    create(:manufacturer)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Modelos'
    click_on 'Registrar novo modelo'

    fill_in 'Nome', with: 'Modelo A'
    fill_in 'Ano', with: '1992'
    select 'Fiat', from: 'Fabricante'
    fill_in 'Cavalos', with: '1200'
    select 'C', from: 'Categoria'
    fill_in 'Combustivel', with: 'Gasolina'
    click_on 'Enviar'

    expect(page).to have_content('Modelo A')
    expect(page).to have_content('1992')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('1200')
    expect(page).to have_content(/C/)
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('Modelo de carro cadastrado com sucesso')
  end

  scenario 'and should fill all fields' do
    user = create(:user)
    
    login_as(user, :scope => :user)
    visit new_car_model_path

    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Fabricante não pode ficar em branco')
    expect(page).to have_content('Categoria não pode ficar em branco' )
    expect(page).to have_content('Motorização contra terceiros')
  end

  scenario 'and if car models doesnt exists' do
    user = create(:user)

    login_as(user, :scope => :user)
    visit root_path 
    
    click_on 'Modelos'

    expect(page).to have_content('Nenhum modelo de carro cadastrado')
  end

  scenario 'and must be authenticated' do
    visit new_car_model_path
    
    expect(current_path).to eq(new_user_session_path)
  end
end