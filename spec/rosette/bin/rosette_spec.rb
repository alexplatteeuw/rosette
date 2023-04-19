# frozen_string_literal: true

require "rails_helper"

RSpec.describe "bin/rosette" do
  let(:executable) { "rosette" }
  let(:from_root)  { "cd #{Rails.root}" }

  context "when the executable is not launch from the root of the application" do
    it "prints an error message" do
      message = <<~ERR

        Could not load your Rails app
        =============================
        Rosette assumes you have a config/environment.rb file it can load. If this is the case, please
        make sure you are using Rosette CLI from the root of your Rails application. Do not hesitate to
        raise an issue if you need further assistance.

      ERR

      # system "#{from_root} && #{executable}"
      expect { system executable }.to output(message).to_stdout_from_any_process
    end
  end
end
