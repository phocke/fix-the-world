Before do
  Capybara.default_host = "example.com"
  DatabaseCleaner.clean
end

After do
  Given "I see valid webpage structure" 
end
