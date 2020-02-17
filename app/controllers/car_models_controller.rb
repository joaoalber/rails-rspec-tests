class CarModelsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_dependencies, only: %i[new edit]
  before_action :load_car_model, only: %i[update show edit destroy]

  def index
    @car_models = CarModel.all
  end

  def show; end

  def edit; end

  def update
    return unless @car_model.update(car_model_params)

    redirect_to @car_model, notice: t('.success')
  end

  def new
    @car_model = CarModel.new
  end

  def create
    @car_model = CarModel.new(car_model_params)
    return redirect_to @car_model, notice: t('.success') if @car_model.save

    load_dependencies
    render :new
  end

  def destroy
    return redirect_to car_models_path, notice: t('.success') if @car_model.destroy
  end

  private

  def car_model_params
    params.require(:car_model).permit(:name, :year, :manufacturer_id, :motorization,
                                      :car_category_id, :fuel_type)
  end

  def load_dependencies
    @car_categories = CarCategory.all
    @manufacturers = Manufacturer.all
  end

  def load_car_model
    @car_model = CarModel.find(params[:id])
  end
end
