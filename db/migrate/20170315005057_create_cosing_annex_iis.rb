class CreateCosingAnnexIis < ActiveRecord::Migration
  def change
    enable_extension 'citext'
    create_table :cosing_annex_iis do |t|
      t.integer :reference_number
      t.citext :chemical_name_inn
      t.text :cas_number
      t.text :ec_number
      t.text :regulation
      t.text :regulated_by
      t.text :other_directives_regulations
      t.text :sccs_opinions
      t.citext :chemical_iupac_name
      t.citext :identified_ingredients_or_substances
      t.text :cmr
      t.datetime :update_date

      t.timestamps null: false, default: "now()"
    end
  end
end
