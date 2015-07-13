class CreatePayslips < ActiveRecord::Migration
  def change
    create_table :payslips do |t|
      t.boolean :paid, :default => false
      t.datetime :start, :default => Time.now
      t.datetime :end
      t.boolean :finalized, :default => false

      t.integer :user_id
      t.integer :seconds, :default => 0

      t.timestamps null: false
    end
  end
end
