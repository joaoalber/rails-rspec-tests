require 'rails_helper'

feature 'Admin destroy subsidiary' do
    scenario 'successfully' do
        user = User.create!(email: "teste@teste.com", password: "123456")
        login_as(user, :scope => :user)
        subs = Subsidiary.create!(name: 'Concessionária BR', cnpj: '75.980.885/0001-31', 
        address: 'r. dos tamoios')
        expect(Subsidiary.exists?(subs.id)).to eq(true) # antes de deletar

        visit root_path
        click_on 'Filiais'
        click_on 'Concessionária BR'
        find(".btn.btn-danger").click

        expect(Subsidiary.exists?(subs.id)).to eq(false)
        expect(page).to have_content('Filial deletada com sucesso')
    end

    scenario 'and must be authenticated' do
        page.driver.submit :delete, subsidiary_path('whatever'), {}
        
        expect(current_path).to eq(new_user_session_path)
    end
end