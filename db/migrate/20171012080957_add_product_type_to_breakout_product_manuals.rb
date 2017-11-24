class AddProductTypeToBreakoutProductManuals < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
  	add_column :breakout_product_manuals, :product_type, :citext
  end
end
