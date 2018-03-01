class RenameColumnDistanceToRadiusForRestaurant < ActiveRecord::Migration
  def change
    rename_column :restaurants, :distance, :radius
    change_column :restaurants, :radius, :integer, default: 0
  end
end
