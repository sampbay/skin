class CreateUserPotentialProducts < ActiveRecord::Migration
  def change
    create_table :user_potential_products do |t|
	  t.integer :user_id
      t.integer :potential_product_id
      t.timestamps null: false
    end
  end
end
