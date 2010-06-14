Given /^I see all wishes tagged with "(.+)"$/ do |name|
  tag = Tag.where(:name => name).first
  visit tag_url(tag)
end

Given /^I see wishes of issue "(.+)" tagged with "(.+)"$/ do |issue, tag|
  tag = Tag.where(:name => tag).first
  visit tag_url(tag, :subdomain => issue)
end
