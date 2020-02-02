class SubsidiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_subsidiary, only: %i[update show edit destroy]

  def index
    @subsidiaries = Subsidiary.all
  end

  def show; end

  def edit; end

  def update
    return render :edit unless @subsidiary.update(subsidiary_params)

    redirect_to @subsidiary, notice: t('.success')
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    return redirect_to @subsidiary, notice: t('.success') if @subsidiary.save

    render :new
  end

  def destroy
    @subsidiary.destroy!
    redirect_to root_path, notice: t('.success')
  end

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

  def load_subsidiary
    @subsidiary = Subsidiary.find(params[:id])
  end
end
