class CarModelsController < ApplicationController
    before_action :authenticate_user!
    before_action :load_dependencies, only: [:new, :edit]
    before_action :load_car_model, only: [:update, :show, :edit, :destroy]

    def index
        @car_models = CarModel.all
    end

    def show
    end

    def edit    
    end

    def update
        return redirect_to @car_model, notice: 'Modelo atualizado com sucesso' if @car_model.update(car_model_params)
    end

    def new
        @car_model = CarModel.new
    end

    def create
        @car_model = CarModel.new(car_model_params)
        return redirect_to @car_model, notice: 'Modelo de carro cadastrado com sucesso' if @car_model.save
        load_dependencies
        render :new
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

    def load_dependencies
        @car_categories = CarCategory.all
        @manufacturers = Manufacturer.all
    end

    def load_car_model
        @car_model = CarModel.find(params[:id])
    end
    
end