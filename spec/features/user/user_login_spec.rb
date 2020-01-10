require 'rails_helper'

feature 'User login' do
	scenario 'successfully' do
		User.create!(email: 'teste@teste.com', password: '123456')

		visit root_path
		click_on 'Entrar'

		within 'form' do
      fill_in 'Email', with: 'teste@teste.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
		end

		expect(page).to have_content('Signed in successfully.')
		expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
    expect(current_path).to eq(root_path)

	end

	scenario 'and logout' do
    User.create!(email: 'teste@teste.com', password: '123456')
    visit new_user_session_path

    within 'form' do
      fill_in 'Email', with: 'teste@teste.com'
      fill_in 'Senha', with: '123456'

      click_on 'Entrar'
    end
    click_on 'Sair'

		expect(page).to have_content 'Signed out successfully.'
		expect(page).to have_link('Entrar')
		expect(page).not_to have_link('Sair')
		
  end

end