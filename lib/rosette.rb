# frozen_string_literal: true

require "rosette/controller"
require "rosette/engine"
require "rosette/manager"
require "rosette/version"

require "i18n/tasks/cli"
require "yaml"

module Rosette
  mattr_accessor :normalize
end
