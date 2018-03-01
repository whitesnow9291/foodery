class ChangeTypeColumnsTotalPrice < ActiveRecord::Migration
  def up
    change_column :orders, :total_price, :decimal, precision: 10, scale: 2
    change_column :option_items, :total_price, :decimal, precision: 10, scale: 2
    change_column :order_items, :total_price, :decimal, precision: 10, scale: 2
  end

  def down
  end
end
