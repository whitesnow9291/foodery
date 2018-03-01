class ChangeHoursFieldFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :hours, :string
    add_column :restaurants, :hours_open, :time, default: Time.utc(1970, 1, 1, 10, 00)
    add_column :restaurants, :hours_close, :time, default: Time.utc(1970, 1, 1, 18, 00)
  end
end
