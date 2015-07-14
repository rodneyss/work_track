class ClientsController < ApplicationController
  before_action :check_user

  # GET /clients
  # GET /clients.json
  def index

    if @current_user.admin
     @clients = Client.all
    else
      @clients = @current_user.company.clients
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
   clients = @current_user.company.clients.id

   if @current_user.admin
    @client = Client.find(params[:id])
   elsif clients.index params[:id]      #checks if the client belongs to user company
    @client = Client.find(params[:id])
   else
    redirect_to root_path
   end

  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
   clients = @current_user.company.clients.id

   if @current_user.admin
    @client = Client.find(params[:id])
   elsif clients.index params[:id]      #checks if the client belongs to user company
    @client = Client.find(params[:id])
   else
    redirect_to root_path
   end

  end

  # POST /clients
  # POST /clients.json
  def create

    redirect_to root_path if !@current_user.boss  #only boss can create clients

    @client = Client.new(client_params)

    @current_user.company.clients << @client

    respond_to do |format|
      if @client.save   #redundant to use save is fired when company.clients << @client
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    @client = Client.find(params[:id])
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    redirect_to root_path if !@current_user.boss #only boss can delete clients

    @client = Client.find(params[:id])
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

    def check_user
      if @current_user.nil?
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params[:client]
    end
end
