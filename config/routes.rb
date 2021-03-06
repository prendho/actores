Rails.application.routes.draw do
  root "home#index"

  get :activity, to: "activity#index", as: :activity

  resources :users
  resources :password_resets
  resources :sessions, only: :create
  resources :invitations, only: [:show, :update]

  concern :answerable do
    resources :respuestas, only: [:index, :new, :show, :edit, :create, :update]
    resources :preguntas, only: :show
  end

  resources :actores, only: [:index, :show, :edit, :update], concerns: :answerable do
    resources :iniciativas, except: :index, concerns: :answerable
  end

  get "me", to: "me#index", as: :me
  patch "me", to: "me#update"

  get "/logout", to: "sessions#destroy", as: :logout
end
