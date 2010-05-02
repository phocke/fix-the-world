Given /^I have no users$/ do
  User.destroy_all
end

Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  unless email.blank?
    visit new_session_url
    fill_in "Email", :with => email
    fill_in "Password", :with => password
    click_button "Log in"
  end
end

When /^I visit profile for "([^\"]*)"$/ do |username|
  user = User.find_by_username!(username)
  visit user_url(user)
end
