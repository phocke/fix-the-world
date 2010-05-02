Factory.define :user do |f|
  f.name "sebcioz"
  f.password "foobar"
  f.password_confirmation { |u| u.password }
  f.email "sebcioz@gmail.com"
end
