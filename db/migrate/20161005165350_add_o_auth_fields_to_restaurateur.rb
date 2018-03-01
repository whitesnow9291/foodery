class AddOAuthFieldsToRestaurateur < ActiveRecord::Migration
  def change
    add_column :restaurateurs, :stripe_uid, :string
    add_column :restaurateurs, :stripe_access_code, :string
    add_column :restaurateurs, :stripe_publishable_key, :string
  end
end
