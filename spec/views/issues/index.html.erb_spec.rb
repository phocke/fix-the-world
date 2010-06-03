require 'spec_helper'

describe "issues/index.html.erb" do
  before(:each) do
    assign(:issues, [
      stub_model(Issue,
        :name => "MyString",
        :description => "MyText"
      ),
      stub_model(Issue,
        :name => "MyString",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of issues" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
