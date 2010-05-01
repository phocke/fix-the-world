class UserSessionsController < ApplicationController
  def new
  end
  
  def create
    authenticate!
    
    if logged_in?
      flash[:notice] = "Login successful!"
    
      render :text => "OK :) Zalogowany jako #{current_user.inspect}"
    end
  end

  def destroy
    logout
    
    flash[:notice] = "Logout successful!"

    render :text => "wylogowano"
  end
  
  def unauthenticated
    flash[:error] = "Incorrect email/password combination"
    
    render :text => "zle dane!"
    return false
  end
end
