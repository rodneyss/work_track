class AddAmountToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :amount, :float
  end
end
