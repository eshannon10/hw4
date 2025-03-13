Rails.application.routes.draw do
  # Root path
  root "places#index"

  # Resources for places and entries
  resources :places
  resources :entries

  # Resources for sessions (login/logout)
  resources :sessions, only: [:new, :create, :destroy]

  # Resources for users (signup)
  resources :users, only: [:new, :create]

  # Named routes for login, logout, and signup
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: 'logout'

  # Active storage routes
  rails_blob_routes
end
