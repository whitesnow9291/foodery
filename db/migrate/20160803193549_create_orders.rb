class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.string :status
      t.integer :menu_items, array: true, default: []
      t.string :delivery_address
      t.float :latitude
      t.float :longitude
      t.timestamps null: false
    end
  end
end
