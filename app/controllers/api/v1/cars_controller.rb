class Api::V1::CarsController < Api::V1::ApiController
  def show
    return render json: @car, status: :ok if @car = Car.find(params[:id])
  end

  def index
    @car = Car.all
    return render json: @car, status: :ok if @car.exists?

    head :not_found
  end

  def create
    @car = Car.new(car_params)
    return render json: @car, status: :created if @car.save!
  end

  def update
    @car = Car.find(params[:id])
    return render json: @car, status: :ok if car_params.present? && @car.update!(car_params)

    head :precondition_failed
  end

  def status
    @car = Car.find(params[:id])
    return unless @car.update!(params.permit(:status))

    render json: @car.as_json(only: :status), status: :ok
  end

  private

  def car_params
    params.permit(:license_plate, :color, :car_model_id, :subsidiary_id, :mileage)
  end
end
