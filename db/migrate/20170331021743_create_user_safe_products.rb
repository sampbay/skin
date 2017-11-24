class CreateUserSafeProducts < ActiveRecord::Migration
  def change
    create_table :user_safe_products do |t|
      t.integer :user_id
      t.integer :safe_product_id
      t.timestamps null: false
    end
  end
end
