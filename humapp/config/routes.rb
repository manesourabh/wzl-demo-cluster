Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  } do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
    get 'sign_out', to: 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "index#home"
  resources :contracts, only: [:index, :new, :create, :show, :update, :edit]
  post 'contracts/assign_sensor', to: 'contracts#assign_sensor'
  post 'contracts/remove_sensor', to: 'contracts#remove_sensor'

  resources :active_sensors, only: [:index, :new, :create, :update, :edit]
  resources :sensor_values, only: [:index]
  get 'sensors/latest_value_batch', to: 'sensor_values#latest_value_batch'
  get 'sensors/updated_data', to: 'sensor_values#updated_data'
  # get 'active_sensors/active', to: 'active_sensors#active'
  # temporary routes
  get 'out', to: "index#out"
end
