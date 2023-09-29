Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  resources :users
  resources :posts, only: [ :show, :create]
  get 'posts/users/:id',to: 'posts#user_post_by_user'
  # resources :likes, only:[:index,:create]
  resources :posts do
    resources :likes 
  end
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user" 
  resources :notifications, only: [:index]
  
  resources :users do
    resources :posts, only:[:create,:update,:show,:destroy]
  end
  resources :posts do
    resources :comments ,only:[:index,:create]
  end
  get 'comments/:id', to: "comments#show"
  
  end