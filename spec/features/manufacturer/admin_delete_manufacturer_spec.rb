require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    user = create(:user)
    manufacturer = create(:manufacturer)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    find('.btn.btn-danger').click

    expect(Manufacturer.exists?(manufacturer.id)).to eq(false)
    expect(page).to have_content('Fabricante deletada com sucesso')
    expect(page).to_not have_content('Fiat')
  end

  scenario 'and must be authenticated' do
    page.driver.submit :delete, manufacturer_path('whatever'), {}

    expect(current_path).to eq(new_user_session_path)
  end
end
