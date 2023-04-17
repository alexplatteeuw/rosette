require_relative "boot"

require "rails"

require "action_controller/railtie"
require "action_view/railtie"
require "active_model/railtie"
require "active_record/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require "rosette"

module ExampleApp
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f

    # For compatibility with applications that use this config
    config.action_controller.include_all_helpers = false

    # Configuration for the application, engines, and railties goes here.
    #
    config.i18n.raise_on_missing_translations = true
    config.i18n.available_locales = [:fr, :en]

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
