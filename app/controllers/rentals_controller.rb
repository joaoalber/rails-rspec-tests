class RentalsController < ApplicationController
	def index
		@rentals = Rental.all
	end

	def show
	end

	def search
		 search = params.require(:q)
		 @rentals = Rental.where(code: "#{search}").to_a
		 @car_category = CarCategory.find(@rentals.first.car_category_id)
		 @client = Client.find(@rentals.first.client_id)
		 render :search
	end
end