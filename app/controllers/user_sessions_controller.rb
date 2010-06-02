class UserSessionsController < ApplicationController
  def show
  end

  def new
  end
  
  def create
    authenticate!
    
    if logged_in?
      flash[:success] = "Login successful!" 
      redirect_to root_url# :text => "OK :) Zalogowany jako #{current_user.name}"
    end
  end

  def destroy
    logout
    flash[:success] = "Logout successful!"
    redirect_to root_url
  end
  
  def unauthenticated
    flash[:error] = "Incorrect email/password combination"
    redirect_to :action=>:new
  end
end
