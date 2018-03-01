class DropRestaurateurModel < ActiveRecord::Migration
  def change
    drop_table :restaurateurs
  end
end
