class PayslipsController < ApplicationController

  before_action :check_user

  include JobsHelper


  def index

    if @current_user.admin
      @payslips = Payslip.all
    elsif @current_user.boss
      @payslips = Payslip.where(:company_id => @current_user.company_id, :paid => false)
    else
      payslip = Payslip.find_by(user_id: @current_user.id, finalized: false)
      @payslips = Payslip.where(id: payslip.user_id, completed: false ) if payslip.present?
      @payslips
    end
  end


  def show
     @payslip = Payslip.find(params[:id])

    if @current_user.admin

    elsif @current_user.boss 
      if @current_user.company_id != @payslip.company_id
        @payslip = nil
      end

    elsif @current_user.id != @payslip.user_id
        @payslip = nil
    end

  end


  def edit
    @payslip = Payslip.find(params[:id])
    redirect_to root_path if !@current_user.boss || @payslip.company_id != @current_user.company_id
  end


  def finalize
    redirect_to root_path if !@current_user.boss

    payslips = Payslip.where(company_id: @current_user.company_id, finalized: false)

    payslips.update_all(:finish => Time.zone.now, :finalized => true)

    if request.xhr?
        render text: "done"
    else
      redirect_to root_path
    end

  end


  def update

    redirect_to root_path if !@current_user.boss


     @payslip = Payslip.find(params[:id])
    if @current_user.boss && @payslip.company_id == @current_user.company_id || @current_user.admin

        respond_to do |format|
          if @payslip.update(payslip_params)
            @payslip.update(seconds: 0) if @payslip.seconds.nil?
            format.html { redirect_to @payslip, notice: 'Payslip was successfully updated.' }
            format.json { render :show, status: :ok, location: @payslip }
          else
            format.html { render :edit }
            format.json { render json: @payslip.errors, status: :unprocessable_entity }
          end
        end
    end
  end

  def destroy
    redirect_to root_path if !@current_user.boss

    @payslip = Payslip.find(params[:id])
    if @current_user.boss && @payslip.company_id == @current_user.company_id || @current_user.admin
      @payslip = Payslip.find(params[:id])
      @payslip.destroy
      respond_to do |format|
        format.html { redirect_to payslips_url, notice: 'Payslip was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end



  private

    def check_user
      if @current_user.nil?
        redirect_to root_path
      end
    end

 
    def payslip_params

       params.require(:payslip).permit(:start, :finish, :seconds, :finalized, :paid)
    end
end
