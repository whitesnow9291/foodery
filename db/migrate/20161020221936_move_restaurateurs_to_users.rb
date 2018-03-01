class MoveRestaurateursToUsers < ActiveRecord::Migration
  def change
    Restaurateur.find_each do |r|
      user = User.create! email: r.email, password: r.email, password_confirmation: r.email
      user.add_role :restaurateur
      r.restaurants.each do |r|
        r.update! user: user
      end
    end
    remove_column :restaurants, :restaurateur_id, :integer
  end
end
