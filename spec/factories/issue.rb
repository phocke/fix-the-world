require "faker"

Factory.define :issue do |f|
  f.name { Faker::Name.name }
  f.description { Faker::Lorem.paragraph }
  f.user { Factory(:user) }
  f.permalink { |i| i.name.to_permalink }
end
