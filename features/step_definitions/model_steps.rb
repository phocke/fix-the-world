Given /^a (.+) with (.+) "([^\"]*)"$/ do |model,attribute,value|
  model.camelize.constantize.make attribute.dasherize => value
end
