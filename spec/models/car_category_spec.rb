require 'rails_helper'

describe CarCategory do
	describe '#rental_price' do
		it 'should generate total price for the day' do
			car_category = CarCategory.new(name: 'A', daily_rate: 100, car_insurance: 40, third_party_insurance: 30)

			result = car_category.rental_price

			expect(result).to eq(170)
		end
	end
end
