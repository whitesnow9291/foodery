class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: ""

    User.where(name: "").update_all(name: "username")
  end
end
