class WishesController < ApplicationController
  before_filter :find_issue #, :set_subdomain
  before_filter :find_wish, :only => [:show, :edit, :update, :destroy, :add_vote]
  load_and_authorize_resource

private
  def find_issue
    @issue ||= Issue.find(:first, :conditions => {:permalink => current_subdomain || params[:id]})
  end

  def find_wish
    @wish = Wish.find(:first, :conditions => {:permalink => params[:id]})
  end

public
  
  def index
    @wishes = @issue.wishes.paginate :page => params[:page], :per_page => 10
  end

  def in_progress
    @wishes = @issue.wishes.in_progress.paginate :page => params[:page], :per_page => 10
  end

  def fixed
    @wishes = @issue.wishes.fixed.paginate :page => params[:page], :per_page => 10
  end

  def show

  end

  def new
    @wish = @issue.wishes.build
  end

  def create
    @wish = current_user.wishes.build(params[:wish]) 
    @wish.issue = @issue

    if @wish.save
      flash[:success] = "Wish was successfully created."
      redirect_to @wish
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @wish.update_attributes(params[:wish])
      flash[:success] = "Wish was successfully updated."
      redirect_to @wish
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @wish.destroy
    flash[:success] = "Wish was successfully destroyed."
    redirect_to wishes_path
  end

  def add_vote
    vote = @wish.votes.build(:user => current_user)

    if vote.save
      flash[:success] = "Successfully added vote."
    else
      flash[:error] = "Don't cheat!"
    end

    redirect_to @wish
  end

end
