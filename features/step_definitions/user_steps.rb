Given /^I have no users$/ do
  User.destroy_all
end

Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

Given /^I have user "([^\"]*)"$/ do |email|
  Factory(:user, :email => email)
end

When /^I sign out$/ do
  visit signout_path
end

When /^I sign up as "([^\"]*)" with name "([^\"]*)" and password "([^\"]*)"$/ do |email, name, password|
  visit signup_path
  fill_in "Email", :with => email
  fill_in "Name", :with => name
  fill_in "Password", :with => password
  fill_in "Password confirmation", :with => password
  click_button "Sign up"
end

Given /^I am signed in as "([^\"]*)" with password "([^\"]*)"?$/ do |email, password|
  visit signin_path
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Log in"
end

When /^I visit profile for "([^\"]*)"$/ do |username|
  user = User.find_by_username!(username)
  visit user_url(user)
end
