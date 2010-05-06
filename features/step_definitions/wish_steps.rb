When /^I delete the wish named "(.+)"$/ do |name|
  wish = Wish.find(:first, :conditions => {:name => name})
  visit wish_path(wish)
  When %{I follow "Destroy"}
end

When /^I edit the wish named "(.+)"$/ do |name|
  wish = Wish.find(:first, :conditions => {:name => name})
  visit edit_wish_path(wish)
end

Then /^I should see the following wishes:$/ do |expected_wishes_table|
  expected_wishes_table.diff!(tableish('table tr', 'td,th'))
end
