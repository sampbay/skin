class CreateAnalyzes < ActiveRecord::Migration
  def change
    create_table :analyzes do |t|

      t.timestamps null: false
    end
  end
end
