class AddProductTypeToSafeProductManuals < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
  	add_column :safe_product_manuals, :product_type, :citext
  end
end
