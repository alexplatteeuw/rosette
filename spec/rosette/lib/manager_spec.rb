# frozen_string_literal: true

require "rails_helper"

RSpec.describe Manager do
  let(:file_path) { Tempfile.new("fr.yml").path }
  let(:translation) { "new translation" }
  let(:result)      { YAML.safe_load(File.read(file_path), symbolize_names: true) }
  let(:locales) do
    {
      "fr" => {
        "a" => {
          "b" => { "c" => "initial translation" },
          "a" => { "b" => "other translation" },
        },
      },
    }
  end

  before(:each) do
    allow(Rails.root).to receive(:join).and_return file_path
    File.write(file_path, locales.to_yaml)
  end

  it "adds the translation" do
    Manager.create("fr", "a.b.d", translation)

    expect(result[:fr][:a][:b][:d]).to eq(translation)
  end

  it "reads the translation" do
    translation = Manager.read("fr", "a.a.b")

    expect(translation).to eq("other translation")
  end

  it "updates the translation" do
    Manager.create("fr", "a.b.c", translation)

    expect(result[:fr][:a][:b][:c]).to eq(translation)
  end

  it "removes the translation" do
    Manager.delete("fr", "a.b.c")

    expect(result[:fr][:a][:b]).to_not have_key(:c)
  end
end
