class AddTransactionToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :transaction_id, :string
  end
end