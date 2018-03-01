class AddLast4ToUser < ActiveRecord::Migration
  def change
    add_column :users, :last4, :string
  end
end
