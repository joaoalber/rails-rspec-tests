require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    Subsidiary.create!(name: 'Concessionária BR', cnpj: '97.799.796/0001-26', address: 'r. dos tamoios')
    Subsidiary.create!(name: 'Concessionária EU', cnpj: '83.604.381/0001-45', address: 'r. dos araguaias')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Concessionária EU'

    expect(page).to have_content('Concessionária EU')
    expect(page).to have_content('83.604.381/0001-45')
    expect(page).to have_content('r. dos araguaias')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    Subsidiary.create!(name: 'Concessionária BR', cnpj: '97.799.796/0001-26', address: 'r. dos tamoios')
    Subsidiary.create!(name: 'Concessionária EU', cnpj: '83.604.381/0001-45', address: 'r. dos araguaias')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Concessionária EU'
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