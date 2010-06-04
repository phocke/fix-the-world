class ApplicationController < ActionController::Base
  
  protect_from_forgery

  helper_method :logged_in?
  before_filter :get_subdomain

  def subdomain_url(subdomain, path="")
    "http://#{subdomain}.#{request.domain}#{request.port_string}#{path}"
  end

private
  def get_subdomain
    @current_subdomain = request.subdomains[0]
  end

end
