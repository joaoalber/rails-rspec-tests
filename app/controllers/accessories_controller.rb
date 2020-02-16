class AccessoriesController < ApplicationController
  def index
    @accessories = Accessory.all
  end

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(accessory_params)
    return redirect_to @accessory, notice: t('.success') if @accessory.save

    render :new
  end

  def show
    @accessory = Accessory.find(params[:id])
  end

  private

  def accessory_params
    params.require(:accessory).permit(:name, :description, :daily_rate, :image)
  end
end
