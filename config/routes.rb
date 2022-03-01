Rails.application.routes.draw do
  devise_for :users
  root to: 'walks#index'

  resources :walk, except: [:show]

  namespace :description do
    resources :walk, only: [:show]
  end

  namespace :live do
    resources :walk, only: [:show]
  end

  namespace :recap_and_review do
    resources :walk, only: [:show]
  end

  namespace :recap_and_save do
    resources :walk, only: %i[show edit]
  end

  namespace :my do
    resources :walk, only: [:index]
  end

  resources :review, only: [:create]
end
