When /^I see the issue named "([^\"]*)"$/ do |name|
  issue = Issue.find(:first, :conditions => {:name => name})
  visit issue_path(issue)
end

When /^I delete the issue named "(.+)"$/ do |name|
  issue = Issue.find(:first, :conditions => {:name => name})
  visit issue_path(issue)
  Then %{I should see "#{name}"}
  When %{I follow "Destroy"}
end

When /^I edit the issue named "(.+)"$/ do |name|
  issue = Issue.find(:first, :conditions => {:name => name})
  visit edit_issue_path(issue)
end

When /^I add vote for issue named "(.+)"$/ do |name|
  issue = Issue.find(:first, :conditions => {:name => name})
  visit add_vote_issue_path(issue)
end

Then /^I should see the following issues:$/ do |expected_issuees_table|
  expected_issues_table.diff!(tableish('table tr', 'td,th'))
end

Then /^issue named "([^\"]*)" should have (\d+) votes?$/ do |name, n|
  issue = Issue.find(:first, :conditions => {:name => name})
  issue.votes.count.should == n.to_i
end
