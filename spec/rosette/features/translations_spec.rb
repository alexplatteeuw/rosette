# frozen_string_literal: true

require "rails_helper"

RSpec.describe "adding translations", type: :feature do
  it "works" do
    visit "/home"

    expect(page).to have_content("Add missing translation")
    expect(page).to have_content("pages.home.greetings")

    fill_in "translations[available_locales][fr]", with: "Bienvenue"
    fill_in "translations[available_locales][en]", with: "Welcome"

    allow(Manager).to receive(:create)
    allow(I18n::Tasks::CLI).to receive(:start)
    allow(I18n).to receive(:translate).and_return "Welcome"

    click_on "Submit"

    expect(Manager).to have_received(:create).twice
    expect(Manager).to have_received(:create).with("fr", "pages.home.greetings", "Bienvenue")
    expect(Manager).to have_received(:create).with("en", "pages.home.greetings", "Welcome")

    expect(page).to_not have_content("Add missing translation")
    expect(page).to have_content("Welcome")
    expect(I18n).to have_received(:translate).with("pages.home.greetings", { default: [], raise: true })
  end
end
