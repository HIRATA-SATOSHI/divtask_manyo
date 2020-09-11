Rails.application.routes.draw do
  get 'sessions/new'
  root to: 'tasks#index'
  resources :tasks
  resources :users
  resources :sessions
end
