RottenMangoes::Application.routes.draw do

  get '/movies/search', to: 'movies#search'

  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  namespace :admin do
    resources :users
  end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'movies#index'
end
