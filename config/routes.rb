Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about' , to: 'pages#about'
  resources :articles
  get 'signup' , to: 'users#new'
  resources :users, except: [:new]
  get 'login' , to: 'sessions#new'
  post 'follow', to: 'users#follow'
  delete 'unfollow', to: 'users#unfollow'
  post 'login' , to: 'sessions#create'
  delete 'logout' , to: 'sessions#destroy'
  resources :categories
end
