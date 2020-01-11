require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
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
    expect(page).to have_content('Filial cadastrada com sucesso')
  end

  scenario 'and the name shouldnt be duplicated' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
    Subsidiary.create!(name: 'General Motors', cnpj: '97.799.796/0001-26', address: 'r. tal')

    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'General Motors'
    fill_in 'CNPJ', with: '97.799.796/0001-26'
    fill_in 'Endereço', with: 'r. tal'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Filial já existente')
  end

  scenario 'and the cnpj must be valid' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'CNPJ', with: '123456790'
    click_on 'Enviar'

    expect(page).to have_content('CNPJ Inválido')
  end

  scenario 'and subsidiary doesnt exists' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
    visit root_path 
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

end