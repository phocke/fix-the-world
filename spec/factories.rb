require "faker"
Factory.define :user do |f|
  f.name Faker::Name.name
  f.password "foobar"
  f.password_confirmation { |u| u.password }
  f.email Faker::Internet.email
end
