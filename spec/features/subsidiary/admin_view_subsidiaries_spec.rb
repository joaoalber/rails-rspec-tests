require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    # Arrange
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
    Subsidiary.create!(name: 'Concessionária BR', cnpj: '97.799.796/0001-26', address: 'r. dos tamoios')
    Subsidiary.create!(name: 'Concessionária EU', cnpj: '83.604.381/0001-45', address: 'r. dos araguaias')

    # Act
    visit root_path
    click_on 'Filiais'
    click_on 'Concessionária EU'
  
    # Assert
    expect(page).to have_content('Concessionária EU')
    expect(page).to have_content('83.604.381/0001-45')
    expect(page).to have_content('r. dos araguaias')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = User.create!(email: "teste@teste.com", password: "123456")
    login_as(user, :scope => :user)
    Subsidiary.create!(name: 'Concessionária BR', cnpj: '97.799.796/0001-26', address: 'r. dos tamoios')
    Subsidiary.create!(name: 'Concessionária EU', cnpj: '83.604.381/0001-45', address: 'r. dos araguaias')

    visit root_path
    click_on 'Filiais'
    click_on 'Concessionária EU'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end