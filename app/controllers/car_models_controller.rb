class CarModelsController < ApplicationController
    before_action :authenticate_user!
    before_action :load_car_categories, :load_manufacturers, only: [:new, :edit]
    before_action :load_car_model, only: [:update, :show, :edit, :destroy]

    def show
    end

    def edit    
    end

    def index
        @car_models = CarModel.all
    end

    def new
        @car_model = CarModel.new
    end

    def create
        @car_model = CarModel.new(car_model_params)
        return redirect_to @car_model, notice: 'Modelo de carro cadastrado com sucesso' if @car_model.save
        load_manufacturers
        load_car_categories
        render :new
    end

    def update
        @car_model.update(car_model_params)
        redirect_to @car_model
    end

    def destroy
       return redirect_to car_models_path, notice: 'Modelo deletado com sucesso' if @car_model.destroy
       render :index 
    end

    private

    def car_model_params
        params.require(:car_model).permit(:name, :year, :manufacturer_id, :motorization, 
                                          :car_category_id, :fuel_type)
    end

    def load_car_categories
        @car_categories = CarCategory.all
    end

    def load_manufacturers
        @manufacturers = Manufacturer.all
    end

    def load_car_model
        @car_model = CarModel.find(params[:id])
    end
    
end