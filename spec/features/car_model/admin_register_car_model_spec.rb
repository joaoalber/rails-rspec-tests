require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
    CarCategory.create!(name: 'Categoria A', daily_rate: 4.50, car_insurance: 20.30,
    third_party_insurance: 14.30)
    Manufacturer.create!(name: 'Fabricante A')

    visit root_path
    click_on 'Modelos'
    click_on 'Registrar novo modelo'

    fill_in 'Nome', with: 'Modelo A'
    fill_in 'Ano', with: '1992'
    select 'Fabricante A', from: 'Fabricante'
    fill_in 'Cavalos', with: '1200'
    select 'Categoria A', from: 'Categoria'
    fill_in 'Combustivel', with: 'Gasolina'
    click_on 'Enviar'

    expect(page).to have_content('Modelo A')
    expect(page).to have_content('1992')
    expect(page).to have_content('Fabricante A')
    expect(page).to have_content('1200')
    expect(page).to have_content('Categoria A')
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('Modelo de carro cadastrado com sucesso')
  end

  scenario 'and should fill all fields' do
    user = User.create!(email: "teste@teste.com", password: "123456")
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
    user = User.create!(email: "teste@teste.com", password: "123456")
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