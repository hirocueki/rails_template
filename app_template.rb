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


# install gems
run 'bundle install --path vendor/bundle --jobs=4'


# 
after_bundle do
  # webpacker install
  run 'bin/rails webpacker:install'

  # set config/application.rb
  application  do
    %q{
      # Set timezone
      config.time_zone = 'Tokyo'
      config.active_record.default_timezone = :local
      # 日本語化
      I18n.available_locales = [:en, :ja]
      I18n.enforce_available_locales = true
      config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
      config.i18n.default_locale = :ja
      # generatorの設定
      config.generators do |g|
        g.test_framework  :rspec, :fixture => true
        g.view_specs false
        g.controller_specs false
        g.routing_specs false
        g.helper_specs false
        g.request_specs false
        g.assets false
        g.helper false
      end
    }
  end

  # Devise
  generate 'devise:install'
  get_remote('config/locales/devise.ja.yml')

  run "bin/rails db:create db:migrate"
  
  git add: '.'
  git commit: "-am 'migrate database'"
end
