require 'rails_helper'

RSpec.describe Car, type: :model do
	describe '.identification' do
    it 'should generate a identification' do
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 40, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_model = CarModel.create!(name: 'Uno', year: '2020',
                                   motorization: '1.0', fuel_type: 'Flex',
                                   car_category: car_category, manufacturer: manufacturer)
      car = Car.create(car_model: car_model, color: 'Azul',
                       license_plate: 'ABC1234', mileage: 100)

      result = car.identification

      expect(result).to eq "Uno - ABC1234 - Azul"
    end

    it 'should not generate a identification if car_model is nil' do
      car = Car.new()

      result = car.identification

      expect(result).to eq 'Carro não cadastrado corretamente'
    end
  end

end
