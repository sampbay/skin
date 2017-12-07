class CreatePotentialProducts < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
    create_table :potential_products do |t|
      t.citext :product, array: true, default: []
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end



