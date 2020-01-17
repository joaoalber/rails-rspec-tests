class ManufacturersController < ApplicationController
    before_action :authenticate_user!
    before_action :load_manufacturer, only: [:update, :show, :edit]

    def index
        @manufacturers = Manufacturer.all
    end

    def show
    end

    def new
        @manufacturer = Manufacturer.new
    end

    def edit
    end

    def create
        @manufacturer = Manufacturer.new(manufacturer_params)
        return redirect_to @manufacturer, notice: 'Fabricante de carro cadastrada com sucesso' if @manufacturer.save
        render :new
    end

    def update
        @manufacturer.update(manufacturer_params)
        redirect_to @manufacturer
    end
    
    def destroy
        @manufacturer = Manufacturer.find(params[:id])
        return redirect_to manufacturers_path, notice: 'Fabricante deletada com sucesso' if @manufacturer.destroy
        render :index
    end

    private

    def manufacturer_params
        params.require(:manufacturer).permit(:name)
    end

    def load_manufacturer
        @manufacturer = Manufacturer.find(params[:id])
    end

end