class CreateUsers < ActiveRecord::Migration
  def change
  	enable_extension 'citext'
    create_table :users do |t|
      t.citext :first_name
      t.citext :last_name
      t.citext :email
      t.string :password_digest
      t.string :auth_token
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.timestamps null: false
    end
  end
end
