require 'rails_helper'

feature 'Admin destroy subsidiary' do
    scenario 'successfully' do
        Subsidiary.create!(name: 'Concessionária BR', cnpj: '75.980.885/0001-31', address: 'r. dos tamoios')

        visit root_path
        click_on 'Filiais'
        click_on 'Concessionária BR'
        click_on 'Deletar'
        expect{ delete :destroy, :id => 1 }

        expect(page).to have_content('Filial deletada com sucesso')
    end
end