class SubsidiariesController < ApplicationController
    before_action :load_subsidiary, only: [:update, :show, :edit, :destroy]

    def index
        @subsidiaries = Subsidiary.all
    end

    def show
    end

    def new
        @subsidiary = Subsidiary.new
    end

    def edit 
    end

    def create
        @subsidiary = Subsidiary.new(subsidiary_params)
        return redirect_to @subsidiary, notice: 'Filial cadastrada com sucesso' if @subsidiary.save
        render :new
    end

    def update
        @subsidiary.update(subsidiary_params)
        redirect_to @subsidiary
    end

    def destroy
        @subsidiary.destroy!
        redirect_to root_path, notice: 'Filial deletada com sucesso'
    end

    private

    def subsidiary_params
        params.require(:subsidiary).permit(:name, :cnpj, :address)
    end

    def load_subsidiary
        @subsidiary = Subsidiary.find(params[:id])
    end

end