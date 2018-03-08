class CreateProducts < ActiveRecord::Migration
  def change
    enable_extension 'citext'
    create_table :products do |t|
      t.citext :brand
      t.citext :product
      t.citext :product_type
      t.text :claims
      t.citext :ingredients
      t.citext :img
      t.timestamps null: false, default: "now()"
    end
  end
end
