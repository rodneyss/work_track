class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :address
      t.integer :company_id

      t.boolean :boss, :default => false
      t.boolean :admin, :default => false


      t.timestamps null: false
    end
  end
end
