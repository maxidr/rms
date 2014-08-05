source 'http://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.0.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3-ruby', :require => 'sqlite3'
#gem 'sqlite3'
gem 'devise'

gem 'cancan'
gem 'formtastic', '~> 1.2.3'
gem 'show_for'
gem 'slim'
gem "slim-rails"
gem "will_paginate", "~> 3.0.pre2"
gem "meta_search"

#gem "hassle"
#gem "compass", ">= 0.10.6"
group :assets do
  gem 'compass-rails'
end
gem "wicked_pdf"

gem 'version'
gem 'spreadsheet'
# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
group :development do
  gem 'annotate'
  #gem 'ruby-debug19'
  gem 'hirb'
end

group :development, :test do
  gem "rspec-rails", "~> 2.0"
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'capybara'
end

group :production do
  gem 'pg'
end