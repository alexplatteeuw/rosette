# frozen_string_literal: true

module Rosette
  class CLI
    COMMANDS = %w[add remove read].freeze

    class << self
      def run(command:)
        return display_help unless command.in?(COMMANDS)

        ask_user_for_key
        send(command)
      end

      private

      def read
        Rosette.available_locales.each do |locale|
          translation = Manager.read(locale, @key)
          puts "Translation for #{locale} is: #{translation}"
        end
      end

      def add
        Rosette.available_locales.each do |locale|
          puts "Please enter #{locale} translation:"
          Manager.create(locale, @key, gets.chomp)
        end
      end

      def remove
        Rosette.available_locales.each do |locale|
          Manager.delete(locale, @key)
        end
      end

      def ask_user_for_key
        puts 'Please provide the key to translation:'
        @key = gets.chomp

        normalize_key!
      end

      def normalize_key!
        Rosette.available_locales.each do |locale|
          @key.delete_prefix!("#{locale}.")
        end
      end

      def display_help
        puts <<~HELP
          Usage: rosette [command]

          Available commands:

            read      read translation from available locales
            add       add a translation to available locales
            remove    remove translation from available locales

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
