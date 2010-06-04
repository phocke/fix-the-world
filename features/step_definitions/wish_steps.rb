# TODO to fix

When /^I see the wish named "([^\"]*)"$/ do |name|
  wish = Wish.find(:first, :conditions => {:name => name})
  visit wish_path(wish, :host => "")
end

When /^I delete the wish named "(.+)"$/ do |name|
  wish = Wish.find(:first, :conditions => {:name => name})
  visit subdomain_url(wish.issue.name, wish_path(wish))
  When %{I follow "Destroy"}
end

When /^I create new wish for issue named "(.+)"$/ do |issue|
  @issue = Issue.find(:first, :conditions => {:name => issue})
  visit new_wish_path(:host => "#{@issue.permalink}.example.com")
end

When /^I edit the wish named "(.+)"$/ do |name|
  wish = Wish.find(:first, :conditions => {:name => name})
  visit subdomain_url(wish.issue.name, edit_wish_path(wish))
end

When /^I add vote for wish named "(.+)"$/ do |name|
  wish = Wish.find(:first, :conditions => {:name => name})
  visit add_vote_issue_wish_path(wish.issue, wish)
end

Then /^I should see the following wishes:$/ do |expected_wishes_table|
  expected_wishes_table.diff!(tableish('table tr', 'td,th'))
end

Then /^wish named "([^\"]*)" should have (\d+) votes?$/ do |name, n|
  wish = Wish.find(:first, :conditions => {:name => name})
  wish.votes.count.should == n.to_i
end
