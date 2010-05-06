require 'spec_helper'

describe WishesController do

  def mock_wish(stubs={})
    @mock_wish ||= mock_model(Wish, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all wishes as @wishes" do
      Wish.stub(:all) { [mock_wish] }
      get :index
      assigns(:wishes).should eq([mock_wish])
    end
  end

  describe "GET show" do
    it "assigns the requested wish as @wish" do
      Wish.stub(:find).with("37") { mock_wish }
      get :show, :id => "37"
      assigns(:wish).should be(mock_wish)
    end
  end

  describe "GET new" do
    it "assigns a new wish as @wish" do
      Wish.stub(:new) { mock_wish }
      get :new
      assigns(:wish).should be(mock_wish)
    end
  end

  describe "GET edit" do
    it "assigns the requested wish as @wish" do
      Wish.stub(:find).with("37") { mock_wish }
      get :edit, :id => "37"
      assigns(:wish).should be(mock_wish)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created wish as @wish" do
        Wish.stub(:new).with({'these' => 'params'}) { mock_wish(:save => true) }
        post :create, :wish => {'these' => 'params'}
        assigns(:wish).should be(mock_wish)
      end

      it "redirects to the created wish" do
        Wish.stub(:new) { mock_wish(:save => true) }
        post :create, :wish => {}
        response.should redirect_to(wish_url(mock_wish))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved wish as @wish" do
        Wish.stub(:new).with({'these' => 'params'}) { mock_wish(:save => false) }
        post :create, :wish => {'these' => 'params'}
        assigns(:wish).should be(mock_wish)
      end

      it "re-renders the 'new' template" do
        Wish.stub(:new) { mock_wish(:save => false) }
        post :create, :wish => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested wish" do
        Wish.should_receive(:find).with("37") { mock_wish }
        mock_wish.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :wish => {'these' => 'params'}
      end

      it "assigns the requested wish as @wish" do
        Wish.stub(:find) { mock_wish(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:wish).should be(mock_wish)
      end

      it "redirects to the wish" do
        Wish.stub(:find) { mock_wish(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(wish_url(mock_wish))
      end
    end

    describe "with invalid params" do
      it "assigns the wish as @wish" do
        Wish.stub(:find) { mock_wish(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:wish).should be(mock_wish)
      end

      it "re-renders the 'edit' template" do
        Wish.stub(:find) { mock_wish(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested wish" do
      Wish.should_receive(:find).with("37") { mock_wish }
      mock_wish.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the wishes list" do
      Wish.stub(:find) { mock_wish(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(wishes_url)
    end
  end

end
