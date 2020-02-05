require 'rails_helper'

feature 'Admin register car' do
  scenario 'sucessfully' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    create(:subsidiary)
    create(:car_model, car_category: car_category, manufacturer: manufacturer)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Registrar novo carro'

    fill_in 'Placa', with: 'CIC3301'
    fill_in 'Cor', with: 'Vermelho'
    select 'Uno', from: 'Modelo'
    fill_in 'Quilometragem', with: '15'
    select 'Américas - Filial I', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Carro registrado com sucesso')
    expect(page).to have_content('CIC3301')
    expect(page).to have_content('Vermelho')
    expect(page).to have_content('Uno')
    expect(page).to have_content('15 Quilômetros')
    expect(page).to have_content('Américas - Filial I')
  end

  scenario 'and must be valid' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_path

    click_on 'Enviar'

    expect(page).to have_content('Placa não pode ficar em branco')
    expect(page).to have_content('Cor não pode ficar em branco')
    expect(page).to have_content('Modelo do carro é obrigatório(a)')
    expect(page).to have_content('Quilometragem não pode ficar em branco')
    expect(page).to have_content('Filial é obrigatório(a)')
  end

  scenario 'and mileage should be greater than 0' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_path

    fill_in 'Quilometragem', with: '0'
    click_on 'Enviar'

    expect(page).to have_content('Quilometragem deve ser maior que 0')
  end

  scenario 'and license_plate should be unique' do
    user = create(:user)
    manufacturer = create(:manufacturer)
    car_category = create(:car_category)
    subsidiary = create(:subsidiary)
    car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
    create(:car, car_model: car_model, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit new_car_path

    fill_in 'Placa', with: 'DXC2132'
    click_on 'Enviar'

    expect(page).to have_content('Placa já está em uso')
  end
end
