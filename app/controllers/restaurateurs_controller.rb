class RestaurateursController < ApplicationController
  authorize_resource class: false

  def index
    @restaurant = current_user.restaurants.build
    @orders = Order.inactive.checkout.where(restaurant: current_user.restaurants.pluck(:id))
  end

  def restaurant_create
    @restaurant = current_user.restaurants.build create_restaurant_params
    current_user.save
    logger.debug @restaurant.errors.inspect
  end

  def order_details
    @order = Order.find params[:id]
    return redirect_to home_path unless can? :read, @order
  end

  def remove_stripe_connect
    current_user.remove_stripe_connect
    redirect_to restaurateur_restaurants_path, notice: I18n.t('stripe_connect_remove')
  end

  def order_confirm
    @order = Order.inactive.where(restaurant: current_user.restaurants.pluck(:id)).find params[:id]
    @order.confirm!
    redirect_to restaurateurs_path
  end

  def fetch_restaurant
    @restaunrant_name = params[:restaurant]
    if @restaunrant_name.blank?
      @orders = Order.inactive.where(restaurant: current_user.restaurants.pluck(:id))
    else
      @orders = Order.inactive.where(restaurant: current_user.restaurants.where(name: @restaunrant_name).pluck(:id))
    end
  end

  private

  def create_restaurant_params
    params.require(:restaurant).permit(:id, :name, :food_type, :address, :phone, :hours_open, :hours_close, :radius, :min_order, :avg_delivery_time, :delivery_fee, :image, :pdf_file_1, :pdf_file_2, :pdf_file_3, :pdf_file_4)
  end
end
