class RentalsController < ApplicationController
	before_action :authenticate_user!
	before_action :load_rental, only: [:update, :show, :edit, :effect]
	before_action :load_dependencies, only: [:edit]
	
	def index
		@rentals = Rental.all
	end

	def show
	end

	def new
		@rental = Rental.new
		load_dependencies
	end

	def create
		@rental = Rental.new(rental_params)
		@rental.code = SecureRandom.hex(6)
		@rental.user = current_user
		return redirect_to @rental, notice: 'Locação agendada com sucesso' if @rental.save
		load_dependencies
		render :new
	end

	def edit
	end

	def update
		return redirect_to @rental, notice: 'Locação atualizada com sucesso' if @rental.update(rental_params)
		render :edit
	end

	def search
		 @search = params.require(:q)
		 @rentals = Rental.where('code LIKE ?', "%#{@search.upcase}%")
	end

	def effect
		@rental.update(status: 'in_progress')
		@car_rental = CarRental.new
		@cars = @rental.car_category.cars
	end

	private

	def load_dependencies
		@car_categories = CarCategory.all
		@clients = Client.all
	end

	def load_rental
		@rental = Rental.find(params[:id])
	end

	def rental_params
		params.require(:rental).permit(:start_date, :end_date, :car_category_id, :client_id)
	end

end