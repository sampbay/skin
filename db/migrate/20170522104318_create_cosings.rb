class CreateCosings < ActiveRecord::Migration
  def change
    enable_extension 'citext'
    create_table :cosings do |t|
      t.integer :COSING_Ref_No
      t.citext :INCI_name
      t.citext :INN_name
      t.citext :Ph_Eur_Name
      t.text :CAS_No
      t.text :EINECS_ELINCS_No
      t.string :Chem_IUPAC_Name_Description
      t.string :Restriction
      t.string :Function
      t.datetime :Update_Date
      t.timestamps null: false, default: "now()"
    end
  end
end