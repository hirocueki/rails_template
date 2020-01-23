#
# hirocueki-rails-template
#
# Usage:
#   rails new appname -d postgresql -m /path/to/app_template.rb
#

def get_remote(src, dest = nil)
  dest ||= src
  repo = 'https://raw.github.com/hirocueki/rails_template/master/files/'
  remote_file = repo + src
  remove_file dest
  get(remote_file, dest)
end


# Check prerequisites
%w{colored}.each do |component|
  run "gem install #{component}"
  Gem.refresh
end

require "colored"

puts "\n========================================================="
puts " HIROCUEKI RAILS 6 TEMPLATE".yellow.bold
puts "=========================================================\n"

gem 'hamlit-rails'
gem 'rails-i18n'

# option: ユーザー認証にdeviseを使うか
if yes?('devise?')
  gem 'devise'
  gem 'devise-i18n'
  gem 'devise-i18n-views'
end

if yes?('dotenv-rails?')
  gem_group :development do
    gem 'dotenv-rails'
  end
  run 'touch .env'
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


# 
after_bundle do

  # Devise
  generate 'devise:install'
  get_remote('config/locales/devise.en.yml')
  get_remote('config/locales/devise.ja.yml')

  rails "db:create db:migrate"
  git add: '.'
  git commit: "-am 'migrate database'"
  
  puts <<-CODE
    # ADD TO config/application.rb
    config.time_zone = 'Tokyo'

    config.i18n.default_locale = :ja

    config.generators do |g|
      g.factory_bot false
      g.factory_bot dir: 'spec/factories'

      g.test_framework :rspec,
        view_specs: false,
        helper_spec: false,
        routing_specs: false
    end
  CODE
end
