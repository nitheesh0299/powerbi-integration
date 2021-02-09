Rails.application.routes.draw do
  root 'home#index'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :powerbi_sessions,only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'powerbi', to: 'powerbi_sessions#new',as: 'powerbi'
  post 'powerbi',to: 'powerbi_sessions#new'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'oauth2', to: 'oauth2#index' , as: 'oauth2'
  get 'powerbi/report', to: 'powerbi_sessions#report'
  get 'powerbi/embed_report', to: 'powerbi_sessions#embed_report'
  get 'powerbi/list_all_report', to: 'powerbi_sessions#list_all_report'
  post 'powerbi/embed_report', to: 'powerbi_sessions#embed_report'
  get 'powerbi/list_all_reports', to: 'powerbi_sessions#list_all_reports'
end