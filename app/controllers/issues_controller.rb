class IssuesController < ApplicationController
  before_filter :find_issue
  load_and_authorize_resource

private
  def find_issue
    @issue = Issue.find(:first, :conditions => {:permalink => params[:id]})
  end

public
  def index
    @issues = Issue.find(:all)
  end

  def show
    @issue = Issue.find(:first, :conditions => {:permalink => params[:id]})
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = current_user.issues.build(params[:issue])

    if @issue.save
      flash[:success] = "Issue was successfully created."
      redirect_to @issue
    else
      render :action => "new"
    end
  end

  def edit
    @issue = Issue.find(:first, :conditions => {:permalink => params[:id]})
  end

  def update
    @issue = Issue.find(:first, :conditions => {:permalink => params[:id]})
    if @issue.update_attributes(params[:issue])
      flash[:succes] = "Issue was successfully updated."
      redirect_to @issue
    else
      render :Action => "edit"
    end
  end

  def destroy
    @issue = Issue.find(:first, :conditions => {:permalink => params[:id]})
    @issue.destroy

    flash[:notice] = "Issue was successfully deleted."
    redirect_to root_path
  end

end
