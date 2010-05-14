class UserSessionsController < ApplicationController
  def show
  end

  def new
  end
  
  def create
    authenticate!
    
    if logged_in?
      flash[:success] = "Login successful!"
    
      render :text => "OK :) Zalogowany jako #{current_user.name}"
    end
  end

  def destroy
    logout
    flash[:success] = "Logout successful!"
    render :text => "wylogowano"
  end
  
  def unauthenticated
    flash[:error] = "Incorrect email/password combination"
    redirect_to :action=>:new
  end
end
