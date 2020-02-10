class CarsController < ApplicationController
  def create_csv
    require 'csv'
    CSV.foreach(params[:car][:file].path, headers: true) do |row|
      data = hashing_and_translating_rows(row)
      Car.find_or_create_by(data.to_hash)
    end
    redirect_to cars_path, notice: t('success')
  end

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

  def new_csv
    @car = Car.new
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
    render :new_csv
  end

  def create
    @car = Car.new(car_params)
    return redirect_to @car, notice: t('.success') if @car.save

    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
    render :new
  end

  private

  def car_params
    params.require(:car).permit(:license_plate, :color, :car_model_id, :subsidiary_id, :mileage)
  end

  def hashing_and_translating_rows(row)
    row.size.times do |i|
      row.to_ary[i][0] = Car.human_attribute_name(row.to_ary[i][0])
    end
    row << car_params.to_hash
  end
end
