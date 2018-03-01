class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :menu_item
      t.string :name
      t.text :description
      t.attachment :image
      t.decimal :price, precision: 8, scale: 2
      t.timestamps null: false
    end
  end
end
