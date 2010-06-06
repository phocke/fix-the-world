class TagsController < ApplicationController

  def show
    if current_subdomain.nil?
      @wishes = Wish.tagged_with(params[:id]).all
    else
      @issue = Issue.where(:permalink => current_subdomain).first
      @wishes = @issue.wishes.tagged_with(params[:id]).all
    end
  end

end
