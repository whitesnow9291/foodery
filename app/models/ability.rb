class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :restaurateur
      can :read, Order do |order|
        user.restaurants.include? order.restaurant
      end
      can :manage, :restaurateur
      can :index, Restaurant
      can :create, Restaurant do |restaurant|
        user.restaurants.include? restaurant
      end
      can :update, Restaurant do |restaurant|
        user.restaurants.include? restaurant
      end
    end

    # can :read, [Order, Restaurant]
  end
end
