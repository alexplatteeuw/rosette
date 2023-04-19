# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rosette::VERSION do
  it "has a version" do
    expect(Rosette::VERSION).to be_truthy
  end
end
