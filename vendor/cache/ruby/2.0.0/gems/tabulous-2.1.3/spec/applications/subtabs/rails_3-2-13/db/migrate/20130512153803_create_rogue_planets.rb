class CreateRoguePlanets < ActiveRecord::Migration
  def change
    create_table :rogue_planets do |t|
      t.string :name

      t.timestamps
    end
  end
end
