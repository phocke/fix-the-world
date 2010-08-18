class ApplicationController < ActionController::Base
  
  #protect_from_forgery

  helper_method :logged_in?
  rescue_from CanCan::AccessDenied, :with => :not_logged_error
  
  def not_logged_error
    flash[:error] = "log in bitch"
    redirect_to signin_url
  end 
end
