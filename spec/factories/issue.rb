require "faker"

Factory.define :issue do |f|
  f.name { Faker::Name.name }
  f.description { Faker::Lorem.paragraph }
  f.user { Factory(:user) }
end
