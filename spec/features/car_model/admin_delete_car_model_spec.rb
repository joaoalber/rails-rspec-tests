require 'rails_helper'

feature 'Admin destroy car model' do
    scenario 'successfully' do
        user = User.create!(email: "teste@teste.com", password: "123456")
        car_category = CarCategory.create!(name: 'Categoria X', daily_rate: '10.44', car_insurance: '30.24', 
																	third_party_insurance: '100.65')
				manufacturer = Manufacturer.create!(name: 'Fabricante A')
				car_model = CarModel.create!(name: 'Modelo A', year: '1992', manufacturer: manufacturer, motorization: '2000', 
                    									car_category: car_category, fuel_type: 'Gasolina')
				
        login_as(user, scope: :user)
        visit root_path
        click_on 'Modelos'
        click_on 'Modelo A'
        find(".btn.btn-danger").click
         
        expect(CarModel.exists?(car_model.id)).to eq(false)
				expect(page).to have_content('Modelo deletado com sucesso')
				expect(page).to_not have_content('Modelo A')
    end

    scenario 'and must be authenticated' do
        visit car_model_path('whatever')
        
        expect(current_path).to eq(new_user_session_path)
    end
end