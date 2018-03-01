class AddFirstNameLastNamePhonePostalcodeDeliveryTimeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :phone, :string
    add_column :orders, :postal_code, :string
    add_column :orders, :delivery_time, :datetime
  end
end
