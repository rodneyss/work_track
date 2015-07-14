class AddReferenceToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :reference, :string
  end
end
