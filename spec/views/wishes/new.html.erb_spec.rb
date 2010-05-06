require 'spec_helper'

describe "wishes/new.html.erb" do
  before(:each) do
    assign(:wish, stub_model(Wish,
      :new_record? => true,
      :name => "MyString",
      :content => "MyText"
    ))
  end

  it "renders new wish form" do
    render

    response.should have_selector("form", :action => wishes_path, :method => "post") do |form|
      form.should have_selector("input#wish_name", :name => "wish[name]")
      form.should have_selector("textarea#wish_content", :name => "wish[content]")
    end
  end
end
