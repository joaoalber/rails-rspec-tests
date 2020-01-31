require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    
    login_as(user, scope: :user) 
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    find(".btn.btn-warning").click
    
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
  end

  scenario 'and must be authenticated' do
    visit edit_manufacturer_path('whatever')
    
    expect(current_path).to eq(new_user_session_path)
  end
end