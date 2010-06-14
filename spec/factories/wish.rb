require "faker"

Factory.define :wish do |f|
  f.name { Faker::Lorem.sentence }
  f.content { Faker::Lorem.paragraph }
  f.user { Factory(:user) }
  f.issue { Factory(:issue) }
  f.permalink { |w| w.name.to_permalink }
  f.tag_list { "a, b, z, x" }
end
