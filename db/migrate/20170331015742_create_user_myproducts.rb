class CreateUserMyproducts < ActiveRecord::Migration
  def change
    create_table :user_myproducts do |t|
      t.integer :user_id
      t.integer :myproduct_id
      t.timestamps null: false
    end
  end
end
