Rails.application.routes.draw do
  namespace :admin do
      resources :users
      root to: "users#index"
    end
  root to: 'visitors#index'
  devise_for :users
  resources :users do
    resources :songs
  end
  resources :songs do
    resources :comments
    resources :likes
  end
end
