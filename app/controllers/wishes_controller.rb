class WishesController < InheritedResources::Base
  load_and_authorize_resource

  def new
    @wish = Wish.new
  end

  def create
    @wish = current_user.wishes.build(params[:wish]) 

    if @wish.save
      redirect_to @wish, :notice => "Wish was successfully created."
    else
      render :action => "new"
    end
  end

end
