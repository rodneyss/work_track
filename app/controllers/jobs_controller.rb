class JobsController < ApplicationController

  before_action :check_user

  include JobsHelper

  # GET /jobs
  # GET /jobs.json
  def index
    if @current_user.admin
      @jobs = Job.all
    elsif @current_user.boss
      @jobs = @current_user.company.jobs
    else
      @jobs = @current_user.jobs
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
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
  
    if job_params[:start] == '1'
      job.update(:start => Time.zone.now)

    else
      time_now = Time.zone.now
      job.update(:end => time_now, :seconds => (time_now - job.start) )

    end

    if request.xhr?
      if job_params[:start] == '1'
        render :json => {:timeTaken => job.start.to_f * 1000}
      else
        clocked_hours = time_spent_hours(job.seconds)
        render :json => {:timeTaken => job.end.to_f * 1000, :hours => clocked_hours }
      end
    end
  end


  def job_complete
    job = Job.find(params[:id])

    job.update(:comments => job_params[:comments], :completed => true)

    binding.pry

    if request.xhr?
        redirect_to root_path
    end

  end

  # POST /jobs
  # POST /jobs.json
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

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])


    respond_to do |format|
      if @job.update(job_params)
        bind_users_job(@job) if job_params[:onsite] 

        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:address, :id, :notes, :start, :end, :seconds, :comments, :client_id, :company_id, :completed, :paid, :photo1, :photo2, :photo3, :reference, :onsite)
    end
end
