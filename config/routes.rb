Rails.application.routes.draw do
  root "home#index"

  resources :users
  resources :sessions, only: :create
  resources :invitations, only: [:show, :update]

  resources :actores, only: [:index, :show] do
    resources :respuestas, only: [:new, :show, :edit, :create, :update]
  end

  get "me", to: "me#index", as: :me
  patch "me", to: "me#update"

  get "/logout", to: "sessions#destroy", as: :logout
end
