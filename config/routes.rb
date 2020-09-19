Rails.application.routes.draw do
  namespace :admin do
    get 'users/new'
    get 'users/edit'
    get 'users/show'
    get 'users/index'
  end
  get 'sessions/new'
  root to: 'tasks#index'
  resources :tasks
  resources :users
  resources :sessions
end
