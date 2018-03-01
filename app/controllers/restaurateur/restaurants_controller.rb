class Restaurateur::RestaurantsController < ApplicationController
  check_authorization

  def index
    authorize! :index, Restaurant
    @restaurants = scoped_restaurants.order(:id)
    @restaurant = scoped_restaurants.new
  end

  def create
    @restaurant = scoped_restaurants.build(create_params)
    authorize! :create, @restaurant
    @restaurant.save
  end

  def toggle
    @restaurant = scoped_restaurants.find(params[:id])
    raise 'unautorized' unless @restaurant
    authorize! :update, @restaurant
    @restaurant.available = !@restaurant.available
    @restaurant.save
    redirect_to restaurateur_restaurants_path
  end

  protected

  def scoped_restaurants
    current_user.restaurants
  end

  def create_params
    params.require(:restaurant).permit(:id, :name, :food_type, :address, :phone, :hours_open, :hours_close, :radius, :min_order, :avg_delivery_time, :delivery_fee, :image, :pdf_file_1, :pdf_file_2, :pdf_file_3, :pdf_file_4)
  end

end
