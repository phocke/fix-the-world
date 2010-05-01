Given /^The following user records$/ do |table|
  table.hashes.each do |hash|
    Factory(User, hash)
  end
end

Given /^I am logged in with email "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  visit new_session_path
  fill_in "email", :with=>email
  fill_in "password", :with=>password
  click_button "Log in"
end

Then /^I should see "([^\"]*)" "([^\"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

