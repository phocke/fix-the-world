require 'spec_helper'

describe "wishes/show.html.erb" do
  before(:each) do
    assign(:wish, @wish = stub_model(Wish,
      :name => "MyString",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyText")
  end
end
