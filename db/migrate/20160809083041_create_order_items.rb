class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :menu_item
      t.integer :qty, default: 1
      t.decimal :total_price, precision: 5, scale: 2
      t.timestamps null: false
    end
    add_index :order_items, :order_id
    add_index :order_items, :menu_item_id
  end
end
