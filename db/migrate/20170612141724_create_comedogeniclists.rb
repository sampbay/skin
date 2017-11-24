class CreateComedogeniclists < ActiveRecord::Migration
  def change
    enable_extension 'citext'
    create_table :comedogeniclists do |t|
      t.citext :ingredient
      t.citext :cas
      t.citext :rating
      t.citext :fulton_1989
      t.citext :morris_kwan_1983
      t.timestamps null: false, default: "now()"
    end
  end
end
