class ChangeRefOptionToOptionGroup < ActiveRecord::Migration
  def change
    remove_column :options, :menu_item_id
    add_reference :options, :option_group, index: true
  end
end
