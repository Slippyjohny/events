require 'sidekiq/web'

Rails.application.routes.draw do


  use_doorkeeper
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
             controller: "clearance/passwords",
             only: [:create, :edit, :update]
  end

  resources :events do
    resources :comments, only: [:new, :create, :destroy]
    resources :documents, only: [:show, :create, :new, :destroy]
    resources :invites, only: [:new, :create]
  end

  resources :notifications, only: %i{index show}
  root 'events#index'
  mount Sidekiq::Web, at: '/sidekiq'
  namespace :api, path: "api" do
    get 'user', to: "users#show"
    post 'authenticate', to: 'authentication#authenticate'
    resources :users, only: [:create]
    resources :events do
      resources :comments, only: [:new, :create, :destroy]
      resources :documents, only: [:show, :create, :new, :destroy]
      resources :invites, only: [:new, :create]
    end
  end
end
