class CreateUserBlacklists < ActiveRecord::Migration
  def change
    create_table :user_blacklists do |t|
      t.integer :user_id
      t.integer :blacklist_id
      t.timestamps null: false
    end
  end
end

