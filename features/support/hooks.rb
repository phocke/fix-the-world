Before do
  #host! "example.com"
  Capybara.default_host = "example.com"
end

After do
  Given "I see valid webpage structure" 
end
