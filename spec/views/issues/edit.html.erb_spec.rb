require 'spec_helper'

describe "issues/edit.html.erb" do
  before(:each) do
    assign(:issue, @issue = stub_model(Issue,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit issue form" do
    render

    response.should have_selector("form", :action => issue_path(@issue), :method => "post") do |form|
      form.should have_selector("input#issue_name", :name => "issue[name]")
      form.should have_selector("textarea#issue_description", :name => "issue[description]")
    end
  end
end
