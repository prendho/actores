Rails.application.routes.draw do
  root "home#index"

  resources :users
  resources :sessions, only: :create

  get "/logout", to: "sessions#destroy", as: :logout
end
