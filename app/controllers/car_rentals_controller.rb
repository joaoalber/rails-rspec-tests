class CarRentalsController < ApplicationController

	def create
		@car_rental = CarRental.new(params.require(:car_rental).permit(:car_id, :rental_id))
		@car_rental.price = @car_rental.car.car_model.car_category.rental_price
		return redirect_to @car_rental, notice: 'Locação efetivada com sucesso' if @car_rental.save!
		#render :new
	end

	def show
		@car_rental = CarRental.find(params[:id])
	end

end