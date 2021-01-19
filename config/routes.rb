Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :users do
    resources :gifts do
      resource :images, only: %i[destroy create]
    end
  end
end
