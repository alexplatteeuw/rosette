# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

gem "pry"
gem "puma"
gem "sqlite3"

gem "rubocop", require: false
gem "rubocop-daemon", require: false
gem "rubocop-performance", require: false
gem "rubocop-rspec", require: false

gem "sprockets-rails"

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
