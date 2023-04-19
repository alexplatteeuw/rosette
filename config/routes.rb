# frozen_string_literal: true

Rosette::Engine.routes.draw do
  resources :translations, only: [:create]
end
