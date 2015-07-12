class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email

      t.integer :company_id

      t.timestamps null: false
    end
  end
end
