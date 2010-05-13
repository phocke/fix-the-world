class WishesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @wishes = Wish.paginate :page=>params[:page], :per_page=>10
  end

  def new
    @wish = Wish.new
  end

  def create
    @wish = current_user.wishes.build(params[:wish]) 

    if @wish.save
      flash[:success] = "Wish was successfully created."
      redirect_to @wish     
    else
      render :action => "new"
    end
  end

  def edit
    @wish = Wish.find(params[:id])
  end

  def update
    @wish = Wish.find(params[:id])
    if @wish.update_attributes(params[:wish])
      flash[:success] = "Wish was successfully updated."
      redirect_to @wish 
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @wish = Wish.find(params[:id])
    @wish.destroy
    flash[:success] = "Wish destroyed"
    redirect_to  wishes_path
  end

  def add_vote
    wish = Wish.find(params[:id])
    vote = wish.votes.build(:user => current_user)

    if vote.save
      flash[:success] = "Successfully added vote."
    else
      flash[:error] = "Don't cheat!"
    end

    redirect_to wish
  end

end
