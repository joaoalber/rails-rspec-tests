class CarsController < ApplicationController

	def index
		@cars = Car.all
	end

	def show
		@car = Car.find(params[:id])
	end

	def new
		@car = Car.new
		@car_models = CarModel.all
		@subsidiaries = Subsidiary.all
	end

	def create
		@car = Car.new(car_params)
		return redirect_to @car, notice: 'Carro cadastrado com sucesso' if @car.save
		@car_models = CarModel.all
		@subsidiaries = Subsidiary.all
		render :new
	end

	private

	def car_params
		params.require(:car).permit(:license_plate, :color, :car_model_id, :subsidiary_id, :mileage)
	end
end