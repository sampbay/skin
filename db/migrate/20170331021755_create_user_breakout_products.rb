class CreateUserBreakoutProducts < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
    create_table :user_breakout_products do |t|
      t.integer :user_id
      t.integer :breakout_product_id
      t.timestamps null: false
    end
  end
end
