class CreateIngredients < ActiveRecord::Migration
  def change
    enable_extension 'citext'
    create_table :ingredients do |t|
      t.citext :name
      t.string :name_href
      t.string :overall_hazard
      t.string :cancer
      t.string :developmental
      t.string :allergies
      t.string :restrictions
      t.string :other_concerns
      t.string :animals
      t.string :score
      t.citext :synonyms, array: true, default: []
      t.timestamps null: false
    end
  end
end


