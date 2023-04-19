# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rosette::CLI do
  before(:each) { allow(Rosette).to receive(:available_locales).and_return %w[fr en] }

  describe 'read command' do
    it 'calls the Manager for each available locale' do
      allow(Rosette::CLI).to receive(:select).and_return 'read'
      allow(Rosette::CLI).to receive(:ask).and_return 'fr.errors.blank'
      allow(Manager).to receive(:read).and_return 'doit être rempli(e)', 'cannot be blank'

      expected_output = <<~MSG
        Translation for fr is: doit être rempli(e)
        Translation for en is: cannot be blank
      MSG

      expect { Rosette::CLI.run }.to output(expected_output).to_stdout

      expect(Manager).to have_received(:read).with 'fr', 'errors.blank'
      expect(Manager).to have_received(:read).with 'en', 'errors.blank'
    end
  end

  describe 'add command' do
    it 'calls the Manager for each available locale' do
      allow(Rosette::CLI).to receive(:select).and_return 'add'
      allow(Rosette::CLI).to receive(:ask).and_return 'errors.blank', 'doit être rempli(e)', 'cannot be blank'
      allow(Manager).to receive(:create)

      Rosette::CLI.run

      expect(Manager).to have_received(:create).with 'fr', 'errors.blank', 'doit être rempli(e)'
      expect(Manager).to have_received(:create).with 'en', 'errors.blank', 'cannot be blank'
    end
  end

  describe 'remove command' do
    it 'calls the Manager for each available locale' do
      allow(Rosette::CLI).to receive(:select).and_return 'remove'
      allow(Rosette::CLI).to receive(:ask).and_return 'errors.blank'
      allow(Manager).to receive(:delete)

      Rosette::CLI.run

      expect(Manager).to have_received(:delete).with 'fr', 'errors.blank'
      expect(Manager).to have_received(:delete).with 'en', 'errors.blank'
    end
  end


  describe 'help command' do
    it 'calls the Manager for each available locale' do
      allow(Rosette::CLI).to receive(:select).and_return 'help'

      expected_output = <<~HELP

        For each command you must provide a key pointing to the translation.
        It can begin with or without the locale. These are all valid keys:

          fr.activemodel.errors.blank
          en.activemodel.errors.blank
          activemodel.errors.blank

      HELP

      expect { Rosette::CLI.run }.to output(expected_output).to_stdout
    end
  end
end
