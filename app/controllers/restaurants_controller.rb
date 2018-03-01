class RestaurantsController < ApplicationController
  before_action :check_location

  def index
    if !params[:tag].blank?
      @tag = params[:tag]
      @restaurants = filter_restaurants Restaurant.available.includes(:tags).tagged_with(@tag).order("RANDOM()")
      @restaurants_count = filter_restaurants(Restaurant.available.all).count
    else
      @restaurants = filter_restaurants Restaurant.available.includes(:tags).all.order("RANDOM()")
      @restaurants_count = @restaurants.count
    end
    @location = session[:postal_code]
    @tags = []
    @restaurants.each do |r|
      r.tags.collect do |tag|
        @tags << tag.name
      end
    end

    @tags.uniq!

    respond_to do |format|
      format.json
      format.html
    end
  end

  def show
    @restaurant = Restaurant.available.find params[:id]
    @menus = @restaurant.menus.order(:id)
  end

  private

  def filter_restaurants restaurants
    restaurants.select do |r|
      distance = DistanceStorage.get session[:lat], session[:lng], r
      distance >= 0 && distance <= r.radius
    end
  end
end
