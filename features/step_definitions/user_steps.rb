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
