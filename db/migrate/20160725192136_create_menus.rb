class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.references :restaurant
      t.string :name
      t.timestamps null: false
    end
  end
end
