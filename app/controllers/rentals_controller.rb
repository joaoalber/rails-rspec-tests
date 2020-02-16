class RentalsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_rental, only: %i[update show edit effect cancel finish_cancel]
  before_action :load_dependencies, only: [:edit]

  def index
    @rentals = Rental.all
  end

  def show; end

  def edit; end

  def update
    return redirect_to @rental, notice: t('.success') if @rental.update(rental_params)

    render :edit
  end

  def new
    @rental = Rental.new
    load_dependencies
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.user = current_user
    return redirect_to @rental, notice: t('.success') if @rental.save

    load_dependencies
    render :new
  end

  def search
    @search = params.require(:q)
    @rentals = Rental.where('code LIKE ?', "%#{@search.upcase}%")
  end

  def new_accessory
    @accessories = Accessory.all
  end

  def create_accessory
    @rental = Rental.find(params[:id])
    return redirect_to @rental, notice: t('.success') if @rental.update(accessory_id: params[:accessory_id])

    @accessories = Accessory.all
    render :new_accessory
  end

  def effect
    @rental.in_progress!
    @car_rental = CarRental.new
    @cars = @rental.car_category.cars
  end

  def cancel
    render :cancel
  end

  def finish_cancel
    @rental.cancelled!
    return render :cancel unless @rental.update(rental_params)

    redirect_to rental_path(@rental)
  end

  private

  def load_dependencies
    @car_categories = CarCategory.all
    @clients = Client.all
  end

  def load_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :car_category_id, :client_id, :cancellation_reason)
  end
end
