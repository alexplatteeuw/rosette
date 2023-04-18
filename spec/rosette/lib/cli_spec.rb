# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rosette::CLI do
  let(:available_locales) { %w[fr en] }

  before(:each) do
    allow(Rosette).to receive(:available_locales).and_return available_locales
  end

  describe '.run' do
    context 'with an existing command' do
      it 'asks for the key to the translation' do
        allow(Rosette::CLI).to receive(:gets).and_return 'fr.errors.blank'

        expect { Rosette::CLI.run(command: 'read') }.to(
          output(/Please provide the key to translation:/).to_stdout
        )
      end
    end

    context 'with an inexisting command' do
      Rosette::CLI::COMMANDS.each do |command|
        it "with #{command}: does not ask for the key to the translation" do
          allow(Rosette::CLI).to receive(:gets).and_return 'fr.errors.blank'

          expect { Rosette::CLI.run(command: 'inexisting') }.to_not(
            output(/Please provide the key to translation:/).to_stdout
          )
        end
      end
    end
  end

  describe 'read command' do
    before(:each) do
      allow(Manager).to receive(:read).and_return 'doit être rempli(e)', 'cannot be blank'
      allow(Rosette::CLI).to receive(:gets).and_return 'fr.errors.blank'
    end

    it 'calls Manager for each available locale' do
      Rosette::CLI.run(command: 'read')

      expect(Manager).to have_received(:read).with('fr', 'errors.blank')
      expect(Manager).to have_received(:read).with('en', 'errors.blank')
    end

    it 'outputs the correct messages' do
      messages = <<~MSG
        Please provide the key to translation:
        Translation for fr is: doit être rempli(e)
        Translation for en is: cannot be blank
      MSG

      expect { Rosette::CLI.run(command: 'read') }.to(
        output(messages).to_stdout_from_any_process
      )
    end
  end

  describe 'add command' do
    before(:each) do
      allow(Manager).to receive(:create)
      allow(Rosette::CLI).to receive(:gets).and_return(
        'fr.errors.blank', 'doit être rempli(e)', 'cannot be blank'
      )
    end

    it 'calls Manager for each available locale' do
      Rosette::CLI.run(command: 'add')

      expect(Manager).to have_received(:create).with('fr', 'errors.blank', 'doit être rempli(e)')
      expect(Manager).to have_received(:create).with('en', 'errors.blank', 'cannot be blank')
    end

    it 'outputs the correct messages' do
      messages = <<~MSG
        Please provide the key to translation:
        Please enter fr translation:
        Please enter en translation:
      MSG

      expect { Rosette::CLI.run(command: 'add') }.to(
        output(messages).to_stdout_from_any_process
      )
    end
  end

  describe 'remove command' do
    before(:each) do
      allow(Manager).to receive(:delete)
      allow(Rosette::CLI).to receive(:gets).and_return('fr.errors.blank')
    end

    it 'calls Manager for each available locale' do
      Rosette::CLI.run(command: 'remove')

      expect(Manager).to have_received(:delete).with('fr', 'errors.blank')
      expect(Manager).to have_received(:delete).with('en', 'errors.blank')
    end

    it 'outputs the correct message' do
      message = <<~MSG
        Please provide the key to translation:
      MSG

      expect { Rosette::CLI.run(command: 'remove') }.to(
        output(message).to_stdout_from_any_process
      )
    end
  end
end
