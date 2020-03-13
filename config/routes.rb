Rails.application.routes.draw do
  get 'sessions/destroy'
  root 'pages#index'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
