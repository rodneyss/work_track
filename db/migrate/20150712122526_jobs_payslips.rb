class JobsPayslips < ActiveRecord::Migration
  def change
    create_table :jobs_payslips, :id => false do |t|
      t.integer :job_id
      t.integer :payslip_id
    end
  end
end
