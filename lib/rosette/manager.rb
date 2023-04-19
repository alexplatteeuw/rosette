# frozen_string_literal: true

class Manager

  ["create", "read", "delete"].each do |verb|
    class_eval <<-METHOD, __FILE__, __LINE__ + 1
      def self.#{verb}(*args)
        new(*args).send('#{verb}')
      end
    METHOD
  end

  def self.normalize!
    I18n::Tasks::CLI.start(["normalize"])
  end

  private

    def initialize(locale, key, translation = nil)
      @file_path   = Rails.root.join("config/locales/#{locale}.yml")
      @keys        = normalize "#{locale}.#{key}"
      @translation = translation
    end

    def read
      stored_translations.dig(*@keys)
    end

    def create
      new_translation      = @keys.reverse.inject(@translation) { |v, k| { k => v } }
      updated_translations = deep_merge(stored_translations, new_translation)
      persist(updated_translations)

      Manager.normalize! if Rosette.normalize
    end

    def delete
      updated_translations = delete_translation(stored_translations, @keys)
      persist(updated_translations)

      Manager.normalize! if Rosette.normalize
    end

    def delete_translation(translations, keys)
      return translations.delete(keys.first) if keys.length == 1

      head, *tail = keys
      delete_translation(translations[head], tail)

      translations
    end

    def persist(translations)
      File.write(@file_path, translations.deep_stringify_keys.to_yaml)
    end

    def stored_translations
      YAML.safe_load(File.read(@file_path), symbolize_names: true)
    end

    def deep_merge(hash, other_hash)
      hash.merge(other_hash) do |_key, this_val, other_val|
        if this_val.is_a?(Hash) && other_val.is_a?(Hash)
          deep_merge(this_val, other_val)
        else
          other_val
        end
      end
    end

    def normalize(key)
      key.split(".").map(&:to_sym)
    end

end
