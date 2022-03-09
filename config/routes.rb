Rails.application.routes.draw do
  devise_for :users
  root to: 'walks#index'

  resources :walks, except: [:show]
  resources :favorite_walks, only: [:create, :destroy]

  namespace :description do
    resources :walks, only: [:show]
  end

  namespace :live do
    resources :walks, only: [:show, :update]
  end

  namespace :recap_and_review do
    resources :walks, only: [:show] do
      resources :favorite_walks, only: [:create, :destroy]
    end
  end

  namespace :recap_and_save do
    resources :walks, only: %i[show edit] do
      resources :favorite_walks, only: [:create, :destroy]
    end
  end

  namespace :my do
    resources :walks, only: [:index, :destroy] do
      resources :favorite_walks, only: [:create, :destroy]
    end
  end

  resources :reviews, only: [:create]
end
