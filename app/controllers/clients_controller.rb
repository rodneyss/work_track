class ClientsController < ApplicationController
  before_action :check_user


  def index

    if @current_user.admin
     @clients = Client.all
    else
      @clients = @current_user.company.clients
    end
  end


  def show
   clients = @current_user.company.clients.ids


   id = params[:id].to_i

   if @current_user.admin
    @client = Client.find(id)
   elsif clients.index id     #checks if the client belongs to user company
    @client = Client.find(id)
   else
    redirect_to root_path
   end

  end


  def new
    @client = Client.new
  end

 
  def edit
   clients = @current_user.company.clients.ids

   id = params[:id].to_i

   if @current_user.admin
    @client = Client.find(id)
   elsif clients.index id      #checks if the client belongs to user company
    @client = Client.find(id)
   else
    redirect_to root_path
   end

  end

 
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

    def client_params
      params.require(:client).permit(:name, :address, :phone, :email)
    end
end

