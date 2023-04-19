# frozen_string_literal: true

require 'tty-prompt'

module Rosette
  class CLI
    class << self
      attr_reader :prompt, :command

      delegate :select, :ask, to: :@prompt

      def run
        ask_for_command

        return help if command == 'help'

        ask_for_key
        send command
      end

      private

      def ask_for_command
        @prompt = TTY::Prompt.new
        @command = select('What do you want to achieve?') do |menu|
          menu.choice('Read a translation', 'read')
          menu.choice('Add a translation', 'add')
          menu.choice('Remove a translation', 'remove')
          menu.choice('Display help', 'help')
        end
      end

      def ask_for_key
        @key = ask 'Please provide the key to translation:'
        normalize_key!
      end

      def normalize_key!
        Rosette.available_locales.each do |locale|
          @key = @key.delete_prefix("#{locale}.")
        end
      end

      # COMMANDS

      def read
        Rosette.available_locales.each do |locale|
          translation = Manager.read(locale, @key)
          puts "Translation for #{locale} is: #{translation}"
        end
      end

      def add
        Rosette.available_locales.each do |locale|
          translation = ask "Please enter #{locale} translation:"
          Manager.create(locale, @key, translation)
        end
      end

      def remove
        Rosette.available_locales.each do |locale|
          Manager.delete(locale, @key)
        end
      end

      def help
        puts <<~HELP

          For each command you must provide a key pointing to the translation.
          It can begin with or without the locale. These are all valid keys:

            fr.activemodel.errors.blank
            en.activemodel.errors.blank
            activemodel.errors.blank

        HELP
      end
    end
  end
end
