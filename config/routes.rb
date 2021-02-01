require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'
  devise_for :users

  resources :users do
    resources :gifts do
      member do
        put 'toggle_selected', as: :select
      end
      resource :images, only: %i[create destroy]
    end
    resource :reviews, only: %i[create destroy]
    resource :assessments, only: %i[create destroy]
  end
end
