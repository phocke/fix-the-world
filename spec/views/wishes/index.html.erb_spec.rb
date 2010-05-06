require 'spec_helper'

describe "wishes/index.html.erb" do
  before(:each) do
    assign(:wishes, [
      stub_model(Wish,
        :name => "MyString",
        :content => "MyText"
      ),
      stub_model(Wish,
        :name => "MyString",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of wishes" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
