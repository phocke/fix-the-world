class IssuesController < ApplicationController
  before_filter :find_issue, :only => [:edit, :update, :destroy]
  load_and_authorize_resource

private
  def find_issue
    @issue = Issue.find(:first, :conditions => {:permalink => params[:id]})
  end

public
  def index
    @issues = Issue.find(:all)
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = current_user.issues.build(params[:issue])

    if @issue.save
      flash[:success] = "Issue was successfully created."
      redirect_to issue_url_with_subdomain(@issue)
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @issue.update_attributes(params[:issue])
      flash[:succes] = "Issue was successfully updated."
      redirect_to issue_url_with_subdomain(@issue)
    else
      render :action => "edit"
    end
  end

  def destroy
    @issue.destroy

    flash[:notice] = "Issue was successfully deleted."
    redirect_to root_url(:subdomain => false)
  end

end
