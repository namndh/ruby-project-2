Rails.application.routes.draw do
  root 'songs#hot_songs'
  get 'hot_songs', to: 'songs#hot_songs'
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  # root to: 'visitors#index'
  devise_for :users
  resources :users do
    resources :songs
  end
  resources :songs do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
    get 'search', to: 'search#index', as: :search
    # get 'login', to: 'sessions#new', as: :login
    # get 'signup', to: 'users#new', as: :signup
    # delete 'logout', to: 'sessions#destroy', as: :logout
end
