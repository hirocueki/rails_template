gem 'hamlit-rails'
gem 'rails-i18n'

if yes?('devise?')
  gem 'devise'
  gem 'devise-i18n'
  gem 'devise-i18n-views'
end

gem_group :development, :test do
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails'
end

gem_group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
