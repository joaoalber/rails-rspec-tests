class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_client, only: %i[edit show update]

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    return redirect_to @client, notice: 'Cliente cadastrado com sucesso' if @client.save

    render :new
  end

  def show; end

  def edit; end

  def update
    return unless @client.update(client_params)

    redirect_to @client, notice: 'Cliente atualizado com sucesso'
  end

  def destroy
    @client = Client.find(params[:id])
    return redirect_to clients_path, notice: 'Cliente deletado com sucesso' if @client.destroy

    render :index
  end

  private

  def load_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:cpf, :name, :email)
  end
end
