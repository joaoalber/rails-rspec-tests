class CarRentalsController < ApplicationController

	def create
		@car_rental = CarRental.new(params.permit(:rental_id, :car_id))
		@car_rental.price = @car_rental.car.car_model.car_category.rental_price
		@car_rental.initial_mileage = @car_rental.car.mileage
		if @car_rental.save!
			Car.find(@car_rental.car_id).update(status: "unavailable")
			return redirect_to rental_path(@car_rental.rental_id), notice: 'Locação efetivada com sucesso' 
		end
		render effect_rental_path
	end

	def show
		@car_rental = CarRental.find(params[:id])
	end

end