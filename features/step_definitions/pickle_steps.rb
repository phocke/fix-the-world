# this file generated by script/generate pickle

# create a model
Given(/^#{capture_model} exists?(?: with #{capture_fields})?$/) do |name, fields|
  create_model(name, fields)
end

# create n models
Given(/^(\d+) #{capture_plural_factory} exist(?: with #{capture_fields})?$/) do |count, plural_factory, fields|
  count.to_i.times { create_model(plural_factory.singularize, fields) }
end

# create models from a table
Given(/^the following #{capture_plural_factory} exists?:?$/) do |plural_factory, table|
  create_models_from_table(plural_factory, table)
end

# find a model
Then(/^#{capture_model} should exist(?: with #{capture_fields})?$/) do |name, fields|
  find_model!(name, fields)
end

# not find a model
Then(/^#{capture_model} should not exist(?: with #{capture_fields})?$/) do |name, fields|
  find_model(name, fields).should be_nil
end

# find models with a table
Then(/^the following #{capture_plural_factory} should exists?:?$/) do |plural_factory, table|
  find_models_from_table(plural_factory, table).should_not be_any(&:nil?)
end

# find exactly n models
Then(/^(\d+) #{capture_plural_factory} should exist(?: with #{capture_fields})?$/) do |count, plural_factory, fields|
  find_models(plural_factory.singularize, fields).size.should == count.to_i
end

# assert equality of models
Then(/^#{capture_model} should be #{capture_model}$/) do |a, b|
  model!(a).should == model!(b)
end

# assert model is in another model's has_many assoc
Then(/^#{capture_model} should be (?:in|one of|amongst) #{capture_model}(?:'s)? (\w+)$/) do |target, owner, association|
  model!(owner).send(association).should include(model!(target))
end

# assert model is not in another model's has_many assoc
Then(/^#{capture_model} should not be (?:in|one of|amongst) #{capture_model}(?:'s)? (\w+)$/) do |target, owner, association|
  model!(owner).send(association).should_not include(model!(target))
end

# assert model is another model's has_one/belongs_to assoc
Then(/^#{capture_model} should be #{capture_model}(?:'s)? (\w+)$/) do |target, owner, association|
  model!(owner).send(association).should == model!(target)
end

# assert model is not another model's has_one/belongs_to assoc
Then(/^#{capture_model} should not be #{capture_model}(?:'s)? (\w+)$/) do |target, owner, association|
  model!(owner).send(association).should_not == model!(target)
end

# assert model.predicate? 
Then(/^#{capture_model} should (?:be|have) (?:an? )?#{capture_predicate}$/) do |name, predicate|
  if model!(name).respond_to?("has_#{predicate.gsub(' ', '_')}")
    model!(name).should send("have_#{predicate.gsub(' ', '_')}")
  else
    model!(name).should send("be_#{predicate.gsub(' ', '_')}")
  end
end

# assert not model.predicate?
Then(/^#{capture_model} should not (?:be|have) (?:an? )?#{capture_predicate}$/) do |name, predicate|
  if model!(name).respond_to?("has_#{predicate.gsub(' ', '_')}")
    model!(name).should_not send("have_#{predicate.gsub(' ', '_')}")
  else
    model!(name).should_not send("be_#{predicate.gsub(' ', '_')}")
  end
end

# model.attribute.should eql(value)
# model.attribute.should_not eql(value)
Then(/^#{capture_model}'s (\w+) (should(?: not)?) be #{capture_value}$/) do |name, attribute, expectation, expected|
  actual_value  = model(name).send(attribute)
  expectation   = expectation.gsub(' ', '_')
  
  case expected
  when 'nil', 'true', 'false'
    actual_value.send(expectation, send("be_#{expected}"))
  when /^[+-]?[0-9_]+(\.\d+)?$/
    actual_value.send(expectation, eql(expected.to_f))
  else
    actual_value.to_s.send(expectation, eql(eval(expected)))
  end
end

# assert size of association
Then /^#{capture_model} should have (\d+) (\w+)$/ do |name, size, association|
  model!(name).send(association).size.should == size.to_i
end