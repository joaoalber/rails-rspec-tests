require 'rails_helper'

describe CarCategory do
  describe '#rental_price' do
    it 'should generate total price for the day' do
      car_category = create(:car_category)

      result = car_category.rental_price

      expect(result).to eq(140)
    end
  end
end
