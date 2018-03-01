class AddDeliveryInstructionsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_instructions, :text
  end
end
