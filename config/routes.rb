Rosette::Engine.routes.draw do
  resources :translations, only: [:create]
end
