class AddHoursPhoneFieldsToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :phone,   :string
    add_column :restaurants, :hours,   :string
  end
end
