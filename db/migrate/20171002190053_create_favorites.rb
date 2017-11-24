class CreateFavorites < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
    create_table :favorites do |t|
      t.citext :product
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
