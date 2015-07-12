class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :address
      t.text :notes
      t.datetime :start
      t.datetime :end
      t.integer :seconds
      t.text :comments
      t.integer :client_id
      t.integer :company_id

      t.boolean :completed
      t.boolean :paid

      t.string :photo1
      t.string :photo2
      t.string :photo3

      t.timestamps null: false
    end
  end
end
