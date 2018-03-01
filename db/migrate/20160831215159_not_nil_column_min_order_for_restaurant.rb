class NotNilColumnMinOrderForRestaurant < ActiveRecord::Migration
  def change
    change_column_default :restaurants, :min_order, 0
    change_column_null :restaurants, :min_order, false, 0
  end
end
