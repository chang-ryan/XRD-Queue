Rails.application.routes.draw do

  get    'signup'  => 'users#new'
  get    'login'   => 'user_sessions#new'
  get    'admin'   => 'user_sessions#admin_password_check'
  post   'login'   => 'user_sessions#create'
  delete 'logout'  => 'user_sessions#destroy'

  get 'user_sessions/new'

  resources :entries
  patch '/entries/:id/scan', to: 'entries#toggle_scanned', as: 'scan_entry'

  resources :users
  resources :account_activations, only: [:edit]

  root to: 'entries#index'
end
