class AddSumToRestaurantToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total_to_restaurant, :decimal, precision: 5, scale: 2
  end
end
