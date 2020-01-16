class RentalsController < ApplicationController
	def index
		@rentals = Rental.all
	end

	def show
		@rental = Rental.find(params[:id])
	end

	def new
		@rental = Rental.new
		@car_categories = CarCategory.all
		@clients = Client.all
	end

	def create
		@rental = Rental.create(rental_params)
		@rental.code = SecureRandom.hex(6)
		@rental.user = current_user
		return redirect_to @rental, notice: 'Locação agendada com sucesso' if @rental.save
		@car_categories = CarCategory.all
		@clients = Client.all
		render :new
	end

	def search
		 @search = params.require(:q)
		 @rentals = Rental.where('code LIKE ?', "%#{@search.upcase}%")
	end

	def effect
		@rental = Rental.find(params[:id])
		@car_rental = CarRental.new
		@cars = @rental.car_category.cars
	end

	private

	def rental_params
		params.require(:rental).permit(:start_date, :end_date, :car_category_id, :client_id)
	end
end