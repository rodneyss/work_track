class CreatePayslips < ActiveRecord::Migration
  def change
    create_table :payslips do |t|
      t.boolean :paid
      t.datetime :start
      t.datetime :end
      t.boolean :finalized

      t.integer :user_id
      t.integer :seconds

      t.timestamps null: false
    end
  end
end
