Given /^I see valid webpage structure$/ do
  Given "I am on the root page"
  Given "I see menu"
end

Given /^I see menu$/ do 
  Then 'I should see "wishes" within "ul#menu"' 
  Then 'I should see "about us" within "ul#menu"'  
  Then 'I should see "fix sth else" within "ul#menu"' 
end
