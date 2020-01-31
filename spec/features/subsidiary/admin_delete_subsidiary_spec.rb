require 'rails_helper'

feature 'Admin destroy subsidiary' do
    scenario 'successfully' do
        user = create(:user)
        subs = create(:subsidiary)

        login_as(user, :scope => :user)
        visit root_path
        click_on 'Filiais'
        click_on 'Américas - Filial I'
        find(".btn.btn-danger").click

        expect(Subsidiary.exists?(subs.id)).to eq(false)
        expect(page).to have_content('Filial deletada com sucesso')
    end

    scenario 'and must be authenticated' do
        page.driver.submit :delete, subsidiary_path('whatever'), {}
        
        expect(current_path).to eq(new_user_session_path)
    end
end