class CreateBlacklists < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
    create_table :blacklists do |t|
      t.citext :ingredient, array: true, default: []
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end




