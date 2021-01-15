Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :users do
    resources :gifts
  end
end
