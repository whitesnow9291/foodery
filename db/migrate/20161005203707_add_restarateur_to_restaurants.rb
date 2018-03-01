class AddRestarateurToRestaurants < ActiveRecord::Migration
  def change
    add_reference :restaurants, :restaurateur, index: true
  end
end
