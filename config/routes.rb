Rails.application.routes.draw do
  # Root path
  root "places#index"

  # Nested resources for places and entries
  resources :places do
    resources :entries, only: [:new, :create]
  end

  # Resources for sessions (login/logout)
  resources :sessions, only: [:new, :create, :destroy]

  # Resources for users (signup)
  resources :users, only: [:new, :create]

  # Named routes for authentication
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # Active Storage routes
  # ✅ This is the correct way to include Active Storage routes
  require "active_storage/engine"
  mount ActiveStorage::Engine => "/rails/active_storage"
end
