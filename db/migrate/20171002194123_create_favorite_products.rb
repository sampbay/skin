class CreateFavoriteProducts < ActiveRecord::Migration
  def change
    create_table :favorite_products do |t|
      t.integer :product_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
