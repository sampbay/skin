class CreateSuggests < ActiveRecord::Migration
  def change
    create_table :suggests do |t|
      t.string :user
      t.string :brand
      t.string :product
      t.string :link
      t.text :ingredients
      t.timestamps null: false
    end
  end
end

