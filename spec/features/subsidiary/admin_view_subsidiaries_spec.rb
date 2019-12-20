require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    # Arrange
    Subsidiary.create!(name: 'Concessionária BR', cnpj: '123456', address: 'r. dos tamoios')
    Subsidiary.create!(name: 'Concessionária EU', cnpj: '654321', address: 'r. dos araguaias')

    # Act
    visit root_path
    click_on 'Filiais'
    click_on 'Concessionária EU'
  
    # Assert
    expect(page).to have_content('Concessionária EU')
    expect(page).to have_content('654321')
    expect(page).to have_content('r. dos araguaias')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Concessionária BR', cnpj: '123456', address: 'r. dos tamoios')
    Subsidiary.create!(name: 'Concessionária EU', cnpj: '654321', address: 'r. dos araguaias')

    visit root_path
    click_on 'Filiais'
    click_on 'Concessionária EU'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end