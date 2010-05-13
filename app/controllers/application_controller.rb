class ApplicationController < ActionController::Base
  
  
  protect_from_forgery

  helper_method :logged_in?
  #before_filter :set_flashes, :if=>"Rails.env == 'development'"

  def set_flashes
    flash[:error], flash[:notice], flash[:success] = faker(3)
  end

  private
  
  def faker(how_many)
    Array.new(how_many){Faker::Lorem.sentence(10+rand(20))}
  end
end
