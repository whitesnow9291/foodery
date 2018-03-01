class AddScheduleInfoToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :schedule_info, :string
  end
end
