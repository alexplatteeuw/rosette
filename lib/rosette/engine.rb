# frozen_string_literal: true

module Rosette
  class Engine < ::Rails::Engine

    isolate_namespace Rosette

    config.after_initialize do |app|
      app.routes.prepend do
        mount Rosette::Engine, at: "/rosette"
      end
    end

    ActiveSupport.on_load(:action_controller_base) do
      include Rosette::Controller
    end

  end
end
