require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  authenticate :user, ->(user) { Rails.env.development? || user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }

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
  resources :invitations, only: %i[index create destroy]
end
