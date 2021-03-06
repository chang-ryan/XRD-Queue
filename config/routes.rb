Rails.application.routes.draw do

  get    'signup'  => 'users#new'
  get    'login'   => 'user_sessions#new'
  post   'login'   => 'user_sessions#create'
  delete 'logout'  => 'user_sessions#destroy'

  resources :appointments, only: [:index, :destroy]
  resources :entries
  patch '/entries/:id/scan', to: 'entries#toggle_scanned', as: 'scan_entry'

  resources :users,               except: [:index]
  resources :account_activations, only:   [:edit]

  resources :calendar, only: [:index, :show]

  get 'admin_panel'                    => 'static_pages#admin_panel'
  get 'admin_panel/users'              => 'users#index'
  get 'admin_panel/db_manage'          => 'static_pages#db_manage'
  get 'admin_panel/db_manage/download' => 'entries#download'
  get 'admin_panel/db_manage/DaD'      => 'entries#download_and_delete'
  get 'admin_panel/usage_stats'        => 'entries#usage_stats'
  get 'admin_panel/controls'           => 'static_pages#admin_panel_controls'

  get 'archive' => 'static_pages#archive'
  get 'about'   => 'static_pages#about'

  post 'notice' => 'static_pages#set_notice'

  root to: 'entries#index'
end
