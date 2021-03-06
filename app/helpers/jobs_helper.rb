module JobsHelper


  Clientd = Struct.new(:id, :name, :first, :last)

  def time_spent_hours seconds
    time_words = ""
    seconds = 0 if seconds.nil?

    
      return "0" if seconds < 1.minute
  

    if seconds >= 1.hour
      hour_done = (seconds / 1.hour).floor
      time_words += hour_done.to_s + (seconds/1.hour > 1 ? " hrs " : " hr ")
     
    end

    minutes_done = (seconds % 1.hour) / 1.minutes
    time_words += minutes_done.to_s + (minutes_done > 1 ? " mins" : " min ")

    time_words

  end



  def bind_users_job job

    clear_old_users job if job.users

    onsite_users = job.onsite.scan /\w+\b/

    onsite_users = onsite_users.map(&:to_i)

    workers = User.where(id: onsite_users)

    workers.each do |worker|

      payslip = check_payslip(worker)


      payslip.jobs << job if !(payslip.jobs.ids.index job.id)  

    end

  end



  def check_payslip worker
    
     payslip = (Payslip.where(user_id: worker.id, finalized: false)).first

     if payslip.nil?
      payslip = Payslip.create()
      worker.payslips << payslip
      @current_user.company.payslips << payslip
     end

     payslip

  end



  def payslip_seconds_update job

    job.payslips.each do |payslip|
      payslip.seconds += job.seconds
      payslip.save
    end

  end


  def job_modified_update_payslips job, dseconds

    job.payslips.each do |payslip|
      payslip.seconds += dseconds
      payslip.save
    end

  end


  def clear_old_users job
    users = job.users.ids
    payslip_ids = (Payslip.where(user_id: users, finalized: false)).ids

    payslip_ids.each do |id|

      job.payslips.destroy(id)

    end

  end


end
