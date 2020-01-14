require 'rails_helper'

feature 'Admin destroy car category' do
    scenario 'successfully' do
        user = User.create!(email: "teste@teste.com", password: "123456")
        car = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
        third_party_insurance: '100.65')
        expect(CarCategory.exists?(car.id)).to eq(true) # antes de deletar

        login_as(user, scope: :user)
        visit root_path
        click_on 'Categorias'
        click_on 'Categoria X'
        find(".btn.btn-danger").click
         
        expect(CarCategory.exists?(car.id)).to eq(false)
        expect(page).to have_content('Categoria deletada com sucesso')
    end

    scenario 'and must be authenticated' do
        visit car_category_path('whatever')
        
        expect(current_path).to eq(new_user_session_path)
    end
end