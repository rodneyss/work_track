class AddOnsiteToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :onsite, :string
  end
end
