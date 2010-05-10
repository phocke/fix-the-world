require "faker"

Factory.define :wish do |f|
  f.name { Faker::Lorem.sentence }
  f.content { Faker::Lorem.paragraph }
  f.user { Factory(:user) }
end