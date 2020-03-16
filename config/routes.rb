Rails.application.routes.draw do
  get 'sessions/destroy'
  root 'pages#index'

  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  get '/signout', to: 'sessions#destroy'

  resources :users
  resources :posts
  resources :follows, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
end
