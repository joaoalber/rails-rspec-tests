class RentalsController < ApplicationController
	def index
		@rentals = Rental.all
	end

	def show
	end

	def search
		 @search = params.require(:q)
		 @rentals = Rental.where('code LIKE ?', "%#{@search.upcase}%")
	end
end