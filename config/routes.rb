Rails.application.routes.draw do
  root 'home#index'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :psessions,only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'powerbi', to: 'psessions#new',as: 'powerbi'
  # post 'powerbi',to: 'ouath2#index'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'oauth2', to: 'oauth2#index' , as: 'oauth2'
end