Rails.application.routes.draw do

  get    'signup'  => 'users#new'
  get    'login'   => 'user_sessions#new'
  post   'login'   => 'user_sessions#create'
  delete 'logout'  => 'user_sessions#destroy'

  get 'user_sessions/new'

  resources :entries, except: :update
  patch '/entries/:id', to: 'entries#toggle_scanned', as: 'scan_entry'

  resources :users

  root to: 'entries#index'
end
