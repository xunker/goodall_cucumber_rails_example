class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :name, :null => false
      t.timestamps
    end

    add_index :widgets, :name, :unique => true
  end
end
