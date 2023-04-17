# frozen_string_literal: true

module Rosette
  class Engine < ::Rails::Engine
    isolate_namespace Rosette

    ActiveSupport.on_load(:action_controller_base) do
      include Rosette::Controller
    end
  end
end
