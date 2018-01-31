class CreateProfiles < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
    create_table :profiles do |t|
      t.citext :type
      t.citext :ethnicity
      t.citext :age 
      t.citext :concerns, array: true, default: []
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end



