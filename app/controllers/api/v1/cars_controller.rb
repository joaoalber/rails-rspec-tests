class Api::V1::CarsController < Api::V1::ApiController
	def show
		return render json: @car, status: 200 if @car = Car.find_by(params[:id])
		head 404
	end

	def index
		return render json: @car, status: 200 if @car = Car.all.exists? ? Car.all : nil
		head 404
	end
end