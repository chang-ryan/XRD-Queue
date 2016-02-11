Rails.application.routes.draw do

  get    'signup'  => 'users#new'
  get    'login'   => 'user_sessions#new'
  post   'login'   => 'user_sessions#create'
  get    'logout'  => 'user_sessions#destroy'

  get 'user_sessions/new'

  resources :entries
  resources :users

  root to: 'entries#index'
end
