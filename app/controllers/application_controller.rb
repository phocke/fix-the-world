class ApplicationController < ActionController::Base
  
  #protect_from_forgery

  include RoutingHelper

  helper_method :logged_in?
  rescue_from CanCan::AccessDenied, :with => :access_denied

  def access_denied
    flash[:error] = "what are u doin' bitch?"
    redirect_to root_url
  end 

end
