require 'rails_helper'

describe Rental do
	describe '#start_date_cannot_be_in_the_past' do
		it 'should not accept dates in the past' do
			rental = Rental.new(start_date: 2.days.ago, end_date: Date.current)
			
			rental.valid?

			expect(rental.errors[:start_date]).to include("Data inicial deve ser depois de hoje")
		end
	end

	describe '#end_date_cannot_be_before_start_date' do
		it 'should not accept end date before start date' do
			rental = Rental.new(start_date: 2.days.ago, end_date: 10.days.ago)

			rental.valid?
			
			expect(rental.errors[:end_date]).to include("Data final deve ser depois da data inicial")
		end
	end


end
