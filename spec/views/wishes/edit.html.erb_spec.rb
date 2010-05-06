require 'spec_helper'

describe "wishes/edit.html.erb" do
  before(:each) do
    assign(:wish, @wish = stub_model(Wish,
      :new_record? => false,
      :name => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit wish form" do
    render

    response.should have_selector("form", :action => wish_path(@wish), :method => "post") do |form|
      form.should have_selector("input#wish_name", :name => "wish[name]")
      form.should have_selector("textarea#wish_content", :name => "wish[content]")
    end
  end
end
