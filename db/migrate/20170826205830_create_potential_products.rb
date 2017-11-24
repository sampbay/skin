class CreatePotentialProducts < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
    create_table :potential_products do |t|
      t.citext :product, null: false
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end