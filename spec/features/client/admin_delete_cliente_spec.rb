require 'rails_helper'

feature 'Admin destroy client' do
    scenario 'successfully' do
        user = User.create!(email: "teste@teste.com", password: "123456")
        client = Client.create!(name: 'Joao', email: 'joao@email.com', cpf: '123.563.212-58')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Clientes'
        click_on 'Joao'
        find(".btn.btn-danger").click
         
        expect(Client.exists?(client.id)).to eq(false)
        expect(page).to have_content('Cliente deletado com sucesso')
        expect(page).to_not have_content('Joao')
    end

    scenario 'and must be authenticated' do
        page.driver.submit :delete, car_category_path('whatever'), {}
        
        expect(current_path).to eq(new_user_session_path)
    end
end