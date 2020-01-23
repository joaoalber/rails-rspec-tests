class Api::V1::CarsController < Api::V1::ApiController

	def show
		return render json: @car, status: 200 if @car = Car.find_by(params[:id])

		head 404
	end

	def index
		return render json: @car, status: 200 if @car = Car.all.exists? ? Car.all : false

		head 404
	end
	
	def create
		return render json: @car, status: 201 if @car = Car.new(car_params).valid? ? Car.create(car_params) : false
		
		head 412
	end
	
	def update
		return head 404 unless @car = Car.find_by(params[:id]) ? Car.find(params[:id]) : false

		render json: @car.as_json(only: [:status]), status: 200 if @car.update(params.permit(:status))
	end


	private

	def car_params
		params.permit(:license_plate, :color, :car_model_id, :subsidiary_id, :mileage)
	end

end