Rails.application.routes.draw do
  devise_for :users
  root to: 'walks#index'

  resources :walks, except: [:show]

  namespace :description do
    resources :walks, only: [:show]
  end

  namespace :live do
    resources :walks, only: [:show, :update]
  end

  namespace :recap_and_review do
    resources :walks, only: [:show] do
      resources :reviews
    end
  end

  namespace :recap_and_save do
    resources :walks, only: %i[show edit]
  end

  namespace :my do
    resources :walks, only: [:index]
  end

  resources :reviews, only: [:create]
end
