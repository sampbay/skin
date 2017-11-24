class CreateBreakoutProductManuals < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
    create_table :breakout_product_manuals do |t|
      t.citext :brand, null: false
      t.citext :product, null: false
      t.citext :ingredients
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end

