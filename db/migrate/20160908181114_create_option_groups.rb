class CreateOptionGroups < ActiveRecord::Migration
  def change
    create_table :option_groups do |t|
      t.references :menu_item
      t.string :name
      t.string :group_type
      t.timestamps null: false
    end

    add_index :option_groups, :menu_item_id
  end
end
