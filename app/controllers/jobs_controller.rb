class JobsController < ApplicationController

  before_action :check_user

  include JobsHelper


  def index #only returning jobs that arnt complete
    if @current_user.admin
      @jobs = Job.all
    elsif @current_user.boss
      @jobs = Job.where(:company_id => @current_user.company.id, :completed => false)
    else
      payslip = Payslip.find_by(user_id: @current_user.id, finalized: false)
      @jobs = Job.where(id: payslip.jobs.ids, completed: false ) if payslip.present?

      @jobs
    end

  end


  def all #return last 10 jobs that are complete
    if @current_user.admin
      @jobs = Job.all
    elsif @current_user.boss
      @jobs = Job.where(company_id: @current_user.company.id, completed: true).order(id: :asc).take(10)
    else
      payslip = Payslip.find_by(user_id: @current_user.id, finalized: false)
      @jobs = Job.where(id: payslip.jobs.ids, completed: true ) if payslip.present?
      @jobs
    end

  end


  def client_job

    client_list = []

    first_job = Job.where(client_id: nil).first
    
    if first_job.present?
      last_job = Job.where(client_id: nil).last
      d = Clientd.new("na", "no client", first_job.year, last_job.year )
      client_list << d
    end

    @current_user.company.clients.each do |client|
      if client.jobs.present?
        d = Clientd.new(client.id, client.name, client.jobs.first.created_at.year, client.jobs.last.created_at.year)
        client_list << d
      end
    end

    if request.xhr?
      render :json => client_list
    end

  end


  def show
  
    if @current_user.admin
      @job = Job.find(params[:id])
    elsif @current_user.boss
      job = @current_user.company.jobs.ids
      if job.index params[:id].to_i
        @job = Job.find(params[:id])
      else
        redirect_to root_path
      end
    else
      job = @current_user.jobs.ids
      if job.index params[:id].to_i
        @job = Job.find(params[:id])
      else
        redirect_to root_path
      end
    end

  end

  # GET /jobs/new
  def new
    redirect_to root_path unless @current_user.boss
    @job = Job.new
    @clients = @current_user.company.clients
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
    @clients = @current_user.company.clients
  end


  def start_stop
    job = Job.find(params[:id])
    
    if job_params[:start] == '1' && !job.start
      job.update(:start => Time.zone.now)

    elsif !job.finish
      time_now = Time.zone.now
      job.update(:finish => time_now, :seconds => (time_now - job.start) )

      payslip_seconds_update job
    end

    if request.xhr?
      if job_params[:start] == '1'
        render :json => {:timeTaken => job.start.to_f * 1000}
      else
        clocked_hours = time_spent_hours(job.seconds)
        render :json => {:timeTaken => job.finish.to_f * 1000, :hours => clocked_hours }
      end
    end
  end


  def job_complete
    job = Job.find(params[:id])

    job.update(:comments => job_params[:comments], :completed => true)

    if request.xhr?
        render :text => "completed"
    end

  end


  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
         @current_user.company.jobs << @job
         bind_users_job(@job) if job_params[:onsite] 

        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @job = Job.find(params[:id])

    respond_to do |format|

      if @job.update(job_params)
        bind_users_job(@job) if job_params[:onsite]


        if @job.finish

          if @job.seconds !=0
              #update payslips connected to job with with delta change to seconds
              if @job.seconds != @job.finish - @job.start
                dseconds = (@job.finish - @job.start) - @job.seconds
                job_modified_update_payslips(@job, dseconds)
              end

          end
          
          @job.update( :seconds => @job.finish - @job.start )

          
          format.html { redirect_to @job, notice: 'Job was successfully updated.' }
          format.json { render :show, status: :ok, location: @job }
        end
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


    def check_user
      if @current_user.nil?
        redirect_to root_path
      end
    end

    def job_params
      params.require(:job).permit(:address, :id, :notes, :start, :finish, :seconds, :comments, :client_id, :company_id, :completed, :paid, :photo1, :photo2, :photo3, :reference, :onsite, :amount)
    end
end
