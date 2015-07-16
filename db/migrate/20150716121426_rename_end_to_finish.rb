class RenameEndToFinish < ActiveRecord::Migration
  def change
    rename_column :payslips, :end, :finish
  end
end
