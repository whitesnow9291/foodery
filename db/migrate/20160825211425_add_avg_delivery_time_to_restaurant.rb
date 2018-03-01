class AddAvgDeliveryTimeToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :avg_delivery_time, :integer, default: 30
  end
end
