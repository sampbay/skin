class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :age
      t.string :skin_type
      t.string :skin_color
      t.text :concerns
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end

