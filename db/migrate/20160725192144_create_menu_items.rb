class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.references :menu
      t.string :name
      t.text :description
      t.attachment :image
      t.decimal :price, precision: 8, scale: 2
      t.timestamps null: false
    end
  end
end
