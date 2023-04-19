# frozen_string_literal: true

require "rosette/cli"
require "rosette/controller"
require "rosette/engine"
require "rosette/manager"
require "rosette/version"

require "i18n/tasks/cli"
require "yaml"

module Rosette

  mattr_accessor :normalize

  def self.available_locales
    Rails.configuration.i18n.available_locales.map(&:to_s)
  end

end
