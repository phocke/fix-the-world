Given /^I have no (.+)$/ do |objects|
  objects.split(", ").each do |o|
    o.classify.constantize.destroy_all
  end
end

Given /^I have (\w+) with (.+)$/ do |object, data|
  hash = {}
  data.split(",").map(&:strip).each do |w|
    pair = w.split(" ")
    hash[pair[0]] = pair[1].gsub('"', "")
  end
  Factory(object, hash)
end

Given /^I have (\w+)$/ do |object|
  Factory(object)
end

Then /^I should have (\d+) (.+)$/ do |number, object|
  number.to_i.should == object.classify.constantize.all.count
end
