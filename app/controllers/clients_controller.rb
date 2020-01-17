class ClientsController < ApplicationController
	before_action :authenticate_user!
	
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

	def show 
		@client = Client.find(params[:id])
	end

	def edit
		@client = Client.find(params[:id])
	end

	def update
		@client = Client.find(params[:id])
		return redirect_to @client if @client.update(client_params)
	end

	private

	def client_params
		params.require(:client).permit(:cpf, :name, :email)
	end

end