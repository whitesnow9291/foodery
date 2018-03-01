class CreateOptionItems < ActiveRecord::Migration
  def change
    create_table :option_items do |t|
      t.references :order_item
      t.references :option
      t.string :name
      t.integer :qty
      t.decimal :total_price,  precision: 5, scale: 2
      t.timestamps null: false
    end
  end
end
