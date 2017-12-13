class RemoveEmailConfirmedAndConfirmTokenToUser < ActiveRecord::Migration
  def change
  	remove_column :users, :email_confirmed, :boolean, :default => false
    remove_column :users, :confirm_token, :string
  end
end
