require 'rails_helper'

describe Car do
  describe '#identification' do
    it 'should generate a identification' do
      car_category = create(:car_category)
      manufacturer = create(:manufacturer)
      car_model = create(:car_model, car_category: car_category, manufacturer: manufacturer)
      car = create(:car, car_model: car_model)

      result = car.identification

      expect(result).to eq 'Uno - DXC2132 - Vermelho'
    end

    it 'should not generate a identification if car_model is nil' do
      car = Car.new

      result = car.identification

      expect(result).to eq 'Carro não cadastrado corretamente'
    end
  end

  describe 'status' do
    it 'should be available at creation' do
      car = Car.new

      expect(car).to be_available
    end
  end
end
