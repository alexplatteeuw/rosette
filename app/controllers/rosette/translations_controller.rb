# frozen_string_literal: true

module Rosette
  class TranslationsController < ApplicationController

    def create
      available_locales.each { |locale, translation| Manager.create(locale, key, translation) }

      Manager.normalize!

      redirect_to redirect_path, notice: "Translation(s) added"
    rescue StandardError => e
      @error_message = e.message
      render_rosette_new(key, redirect_path)
    end

    private

      def translations_params
        params.require(:translations).permit(:key, :redirect_path, available_locales: {})
      end

      def available_locales
        translations_params[:available_locales]
      end

      def key
        translations_params[:key]
      end

      def redirect_path
        URI.parse(translations_params[:redirect_path]).to_s
      end

  end
end
