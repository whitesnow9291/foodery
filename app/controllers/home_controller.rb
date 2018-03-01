class HomeController < ApplicationController

  def home
    @user = current_user || User.new
  end

  def coming_soon
    render 'coming_soon', layout: 'coming_soon'
  end
end
