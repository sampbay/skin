class ChangeProfileColumnName < ActiveRecord::Migration
  def change
  	rename_column :profiles, :type, :skin_type
  end
end
