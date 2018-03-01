class AddFeeAndAvailabelToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :fee, :decimal, precision: 8, scale: 2, default: 0.05
    add_column :restaurants, :available, :boolean, default: false
  end
end
