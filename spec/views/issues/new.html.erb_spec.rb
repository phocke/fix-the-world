require 'spec_helper'

describe "issues/new.html.erb" do
  before(:each) do
    assign(:issue, stub_model(Issue,
      :new_record? => true,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new issue form" do
    render

    response.should have_selector("form", :action => issues_path, :method => "post") do |form|
      form.should have_selector("input#issue_name", :name => "issue[name]")
      form.should have_selector("textarea#issue_description", :name => "issue[description]")
    end
  end
end
