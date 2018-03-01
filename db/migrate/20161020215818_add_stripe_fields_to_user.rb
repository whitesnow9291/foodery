class Restaurateur < ActiveRecord::Base
  has_many :restaurants
end

class AddStripeFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_uid, :string
    add_column :users, :stripe_access_code, :string
    add_column :users, :stripe_publishable_key, :string
    add_reference :restaurants, :user, index: true
  end
end
