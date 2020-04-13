Rails.application.routes.draw do
  resources :articles do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users
  root to: 'home#index'
end
