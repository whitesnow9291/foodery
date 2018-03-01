class RemoveQtyFromOrderItem < ActiveRecord::Migration
  def change
    remove_column :order_items, :qty
  end
end
