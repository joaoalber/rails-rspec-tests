require 'rails_helper'

feature 'Admin destroy car category' do
    scenario 'successfully' do
        car = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
        third_party_insurance: '100.65')
        expect(CarCategory.exists?(car.id)).to eq(true) # antes de deletar

        visit root_path
        click_on 'Categorias'
        click_on 'Categoria X'
        click_on 'Deletar'
         
        expect{ delete :destroy, id: car.id }
        expect(CarCategory.exists?(car.id)).to eq(false)
        expect(page).to have_content('Categoria deletada com sucesso')
    end
end