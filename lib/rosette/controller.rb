# frozen_string_literal: true

module Rosette
  module Controller
    extend ActiveSupport::Concern

    included { rescue_from I18n::MissingTranslationData, with: :add_missing_translation_data }

    private

    def add_missing_translation_data(exception)
      key = exception.message.sub(/translation missing:.+?\./, '')

      render_rosette_new(key, request.fullpath)
    end

    def render_rosette_new(key, redirect_path)
      render 'rosette/new', layout: 'rosette/application', locals: { key: key, redirect_path: redirect_path }
    end
  end
end
