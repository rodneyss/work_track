class PayslipsController < ApplicationController
  before_action :set_payslip, only: [:show, :edit, :update, :destroy]
  before_action :check_user

  # GET /payslips
  # GET /payslips.json
  def index
    @payslips = Payslip.all
  end

  # GET /payslips/1
  # GET /payslips/1.json
  def show
  end

  # GET /payslips/new
  def new
    @payslip = Payslip.new
  end

  # GET /payslips/1/edit
  def edit
  end

  # POST /payslips
  # POST /payslips.json
  def create
    @payslip = Payslip.new(payslip_params)

    respond_to do |format|
      if @payslip.save
        format.html { redirect_to @payslip, notice: 'Payslip was successfully created.' }
        format.json { render :show, status: :created, location: @payslip }
      else
        format.html { render :new }
        format.json { render json: @payslip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payslips/1
  # PATCH/PUT /payslips/1.json
  def update
    respond_to do |format|
      if @payslip.update(payslip_params)
        format.html { redirect_to @payslip, notice: 'Payslip was successfully updated.' }
        format.json { render :show, status: :ok, location: @payslip }
      else
        format.html { render :edit }
        format.json { render json: @payslip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payslips/1
  # DELETE /payslips/1.json
  def destroy
    @payslip.destroy
    respond_to do |format|
      format.html { redirect_to payslips_url, notice: 'Payslip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payslip
      @payslip = Payslip.find(params[:id])
    end

    def check_user
      if @current_user.nil?
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payslip_params
      params[:payslip]
    end
end
