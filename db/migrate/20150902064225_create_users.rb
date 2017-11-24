class CreateUsers < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
    create_table :users do |t|
      t.citext :first_name
      t.citext :last_name
      t.citext :email
      t.string :password_digest
      t.timestamps null: false
    end
  end
end
