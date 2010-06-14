require 'spec_helper'

describe "issues/show.html.erb" do
  before(:each) do
    assign(:issue, @issue = stub_model(Issue,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyText")
  end
end
