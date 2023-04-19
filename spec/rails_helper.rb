# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require File.expand_path("../spec/example_app/config/environment", __dir__)

require "rspec/rails"
require "selenium/webdriver"

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
  config.before(:all, type: :feature) do
    Capybara.server = :puma, { Silent: true }
  end
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: ["headless", "no-sandbox", "disable-gpu", "disable-dev-shm-usage"],
  )

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :headless_chrome

ActiveRecord::Migration.maintain_test_schema!
