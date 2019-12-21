class SubsidiariesController < ApplicationController
    def index
        @subsidiaries = Subsidiary.all
    end

    def show
        @subsidiary = Subsidiary.find(params[:id])
    end

    def new
        @subsidiary = Subsidiary.new
    end

    def edit
        @subsidiary = Subsidiary.find(params[:id])
    end

    def create
        @subsidiary = Subsidiary.new(subsidiary_params)
        if @subsidiary.save
            redirect_to @subsidiary
        else    
            render :new
        end
    end

    def update
        @subsidiary = Subsidiary.find(params[:id])
        @subsidiary.update(subsidiary_params)
        redirect_to @subsidiary
    end

    def destroy
        @subsidiary = Subsidiary.find(params[:id])
        @subsidiary.destroy!
        flash[:notice] = 'Filial deletada com sucesso'
        redirect_to root_path
    end

    private

    def subsidiary_params
        params.require(:subsidiary).permit(:name, :cnpj, :address)
    end

end