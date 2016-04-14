Rails.application.routes.draw do

  get    'signup'  => 'users#new'
  get    'login'   => 'user_sessions#new'
  post   'login'   => 'user_sessions#create'
  delete 'logout'  => 'user_sessions#destroy'

  get 'user_sessions/new'

  resources :entries
  patch '/entries/:id/scan', to: 'entries#toggle_scanned', as: 'scan_entry'

  resources :users,               except: [:index]
  resources :account_activations, only:   [:edit]

  get 'admin_panel'       => 'static_pages#admin_panel'
  get 'admin_panel/users' => 'users#index'

  root to: 'entries#index'
end
