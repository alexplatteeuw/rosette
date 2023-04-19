# frozen_string_literal: true

require "tty-prompt"

module Rosette
  class CLI

    class << self

      attr_reader :prompt, :command

      delegate :select, :ask, to: :@prompt

      def run
        loop do
          ask_for_command
          return exit 0 if exit_cli?

          next display_help if help?
          next normalize! if normalize?

          ask_for_key
          send command
        end
      end

      private

        def ask_for_command
          @prompt  = TTY::Prompt.new
          @command = select("\nWhat do you want to achieve?") do |menu|
            menu.choice("1. Read a translation", "read")
            menu.choice("2. Add a translation", "add")
            menu.choice("3. Remove a translation", "remove")
            menu.choice("4. Normalize locales", "normalize")
            menu.choice("5. Help", "help")
            menu.choice("6. Exit", "exit_cli")
          end
        end

        def ask_for_key
          @key = ask "Please provide the key to translation:"
          normalize_key!
        end

        def normalize_key!
          Rosette.available_locales.each do |locale|
            @key = @key.delete_prefix("#{locale}.")
          end
        end

        def exit_cli?  = command == "exit_cli"
        def help?      = command == "help"
        def normalize? = command == "normalize"

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

        def normalize!
          Manager.normalize!
        end

        def display_help
          puts <<~HELP

            For commands read/add/remove you must provide a key pointing to the translation.
            It can begin with or without the locale. These keys are all considered equivalent:

              fr.activemodel.errors.blank
              en.activemodel.errors.blank
              activemodel.errors.blank

          HELP
        end

    end

  end
end
