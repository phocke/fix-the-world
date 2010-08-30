When /^I see the wish named "([^\"]*)"$/ do |name|
  wish = Wish.first(:conditions => {:name => name})
  visit wish_url_with_subdomain(wish)
end

When /^I see in progress wishes for issue named "([^\"]*)"$/ do |name|
  issue = Issue.find(:first, :conditions => {:name => name})
  visit in_progress_wish_url(:subdomain => issue.permalink)
end

When /^I see fixed wishes for issue named "([^\"]*)"$/ do |name|
  issue = Issue.find(:first, :conditions => {:name => name})
  visit fixed_wish_url(:subdomain => issue.permalink)
end

When /^I delete the wish named "(.+)"$/ do |name|
  When %{I see the wish named "#{name}"}
  When %{I follow "Destroy wish"}
end

When /^I create new wish for issue named "(.+)"$/ do |name|
  issue = Issue.find(:first, :conditions => {:name => name})
  visit new_wish_url(:subdomain => issue.permalink)
end

When /^I edit the wish named "(.+)"$/ do |name|
  wish = Wish.find(:first, :conditions => {:name => name})
  visit edit_wish_url(wish, :subdomain => wish.issue.permalink)
end

When /^I add vote for wish named "(.+)"$/ do |name|
  wish = Wish.find(:first, :conditions => {:name => name})
  visit add_vote_wish_url(wish, :subdomain => wish.issue.permalink)
end

Then /^I should see the following wishes:$/ do |expected_wishes_table|
  expected_wishes_table.diff!(tableish('table tr', 'td,th'))
end

Then /^wish named "([^\"]*)" should have (\d+) votes?$/ do |name, n|
  wish = Wish.find(:first, :conditions => {:name => name})
  wish.votes.count.should == n.to_i
end
