class CreateGalaxiesLenticularGalaxies < ActiveRecord::Migration
  def change
    create_table :galaxies_lenticular_galaxies do |t|
      t.string :name

      t.timestamps
    end
  end
end
