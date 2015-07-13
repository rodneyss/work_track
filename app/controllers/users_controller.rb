class UsersController < ApplicationController
  before_action :check_user

  # GET /users
  # GET /users.json
  def index
    if @current_user.admin == true
      @users = User.all
    elsif @current_user.boss == true
      @users = User.where(:company => @current_user.company)
    else
      redirect_to root_path
    end
      
  end

  # GET /users/1
  # GET /users/1.json
  def show
    
    if @current_user.admin
      @user = User.find(params[:id])
    elsif @current_user.boss
      @user = User.find(params[:id])
      if @user.company != @current_user.company || @user.admin
        @user = @current_user
      end
      
    else
      @user = @current_user
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def new_worker_company
    @user = User.new
    @user.company_id = params[:id].to_i

  end

  # GET /users/1/edit
  def edit
    
    if @current_user.admin
      @user = User.find(params[:id])
    elsif @current_user.boss
      @user = User.find(params[:id])
      if @user.company != @current_user.company || @user.admin
        @user = @current_user
      end
      
    else
      @user = @current_user
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    @current_user.company.users << @user if !@current_user.admin && @current_user.boss

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    # Never trust parameters from the scary internet, only allow the white list through.
    def check_user
      if @current_user.nil?
        redirect_to root_path
      end
    end


     def user_params
      params.require(:user).permit(:name, :id, :email, :address, :phone, :password, :company_id, :boss)
    end
end
