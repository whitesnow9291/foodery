class RemoveMenuItemsFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :menu_items, :integer, array: true, default: []
  end
end
