class WishesController < InheritedResources::Base
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
      redirect_to @wish, :notice => "Wish was successfully created."
    else
      render :action => "new"
    end
  end

  def add_vote
    wish = Wish.find(params[:id])
    vote = wish.votes.build(:user => current_user)

    if vote.save
      flash[:notice] = "Successfully added vote."
    else
      flash[:error] = "Don't cheat!"
    end

    redirect_to :back
  end

end
