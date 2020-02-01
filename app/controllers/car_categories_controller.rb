class CarCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_car_category, only: %i[update show edit destroy]

  def index
    @car_categories = CarCategory.all
  end

  def show; end

  def edit; end

  def update
    return unless @car_category.update(car_category_params)

    redirect_to @car_category, notice: 'Categoria atualizada com sucesso'
  end

  def new
    @car_category = CarCategory.new
  end

  def create
    @car_category = CarCategory.new(car_category_params)
    return render :new unless @car_category.save

    redirect_to @car_category, notice: 'Categoria de carro cadastrada com sucesso'
  end

  def destroy
    @car_category.destroy!
    redirect_to car_categories_path, notice: 'Categoria deletada com sucesso'
  end

  private

  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end

  def load_car_category
    @car_category = CarCategory.find(params[:id])
  end
end
