class ManufacturersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_manufacturer, only: %i[update show edit destroy]

  def index
    @manufacturers = Manufacturer.all
  end

  def show; end

  def edit; end

  def update
    return unless @manufacturer.update(manufacturer_params)

    redirect_to @manufacturer, notice: 'Fabricante atualizada com sucesso'
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    return render :new unless @manufacturer.save

    redirect_to @manufacturer, notice: 'Fabricante de carro cadastrada com sucesso'
  end

  def destroy
    return render :index unless @manufacturer.destroy

    redirect_to manufacturers_path, notice: 'Fabricante deletada com sucesso'
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end

  def load_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end
end
