class CreateHealthcanadahotlists < ActiveRecord::Migration
  def change
    enable_extension 'citext'
    create_table :healthcanadahotlists do |t|
      t.citext :ingredient
      t.text :cas
      t.citext :synonyms
      t.text :status
      t.citext :ingredient_original
      t.text :conditions_of_use
      t.text :maximum_concentration_permitted
      t.text :warnings_and_cautions
      t.datetime :update_date

      t.timestamps null: false, default: "now()"
    end
  end
end
