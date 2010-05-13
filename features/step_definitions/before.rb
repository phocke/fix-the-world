# create models from a table
Given(/^i see menu$/) do 
  Then 'I should see "wishes" within "ul.menu"' 
  Then 'I should see "about us" within "ul.menu"'  
  Then 'I should see "fix sth else" within "ul.menu"' 
end

#find a model
#Then(/^{capture_model} should exist(?: with #{capture_fields})?$/) do |name, fields|
  #find_model!(name, fields)
#end
