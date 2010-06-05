class ApplicationController < ActionController::Base
  
  protect_from_forgery

  helper_method :logged_in?

end
