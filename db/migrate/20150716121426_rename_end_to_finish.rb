class RenameEndToFinish < ActiveRecord::Migration
  def change
    rename_column :payslips, :end, :finish
    rename_column :jobs, :end, :finish
  end
end
