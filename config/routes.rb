Rails.application.routes.draw do
  authenticated :user do
    root :to => 'songs#index'
    get 'my_songs', to: 'songs#my_songs', as: :my_songs
  end
  root :to => 'visitors#index'
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  devise_for :users
  resources :users do
    resources :songs
  end
  resources :songs do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  get 'search', to: 'search#index', as: :search
end
