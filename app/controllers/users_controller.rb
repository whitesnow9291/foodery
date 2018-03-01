class UsersController < ApplicationController
  respond_to :json

  CANADA_POSTCODE = /^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$/

  def set_location
    if permit_params[:postal_code] && !((loc = Geocoder.search "#{permit_params[:postal_code]}, Canada").empty?)
      @result = {}
      loc = loc.first
      session[:lat] = loc.geometry["location"]["lat"]
      session[:lng] = loc.geometry["location"]["lng"]
      session[:address] = @result[:address] = loc.formatted_address
      session[:postal_code] = permit_params[:postal_code]
      distance_calculator = DistanceCalculator.new({lat: session[:lat], lng: session[:lng]}, Restaurant.where.not(latitude: nil, longitude: nil))
      distance_calculator.process
    end
  end

  private

  def permit_params
    params.require(:user).permit(:postal_code)
  end
end