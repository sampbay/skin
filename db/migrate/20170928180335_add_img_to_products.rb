class AddImgToProducts < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
    add_column :products, :img, :citext
  end
end
