class AddDistanceMinimumOrderAndDeliveryFeeToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :distance, :integer
    add_column :restaurants, :min_order, :decimal
    add_column :restaurants, :delivery_fee, :decimal, default: 15
  end
end
