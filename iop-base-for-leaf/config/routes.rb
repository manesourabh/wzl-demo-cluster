Rails.application.routes.draw do
  use_doorkeeper
  # devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "index#home"
  get '/docs', to: 'index#docs'

  scope :groups do
    get '/show', to: 'groups#showall'
    get 'show/:group_id', to: 'groups#show'
    post 'add', to: 'groups#add_group'
    delete '/memeber/:id', to: 'groups#destroy_member', as: "delete_group_member"
    delete '/dataset/:id', to: 'groups#destroy_dataset', as: "delete_group_dataset"
    post 'addmember', to: 'groups#add_member'
    post '/adddataset', to: 'groups#add_dataset'
    post '/addgrouprole', to: 'groups#add_group_role'
    delete '/grouprole/:id', to: 'groups#destroy_group_role', as: "delete_group_role"
    get '/memberrole', to: 'groups#group_member_roles'
    post '/addmemberrole', to: 'groups#add_group_member_role'
    delete '/deletememberrole/:id', to: 'groups#destroy_group_member_role', as: "delete_member_group_role"
  end

  # get 'gear_shafts/', to: 'gear_shafts#index'
  # post 'gear_shafts/import', to: 'gear_shafts#import'
  # LeafFailuer
  get 'leaf/', to: 'leafs#index'
  post 'leaf/import', to: 'leafs#import'

  # get 'xkm/', to: 'xkm#index'
  # post 'xkm/import', to: 'xkm#import'

  # get 'matches/', to: 'matches#index'

  # Temporary route for testing perpose
  get "/test", to: "index#test"

  # API routes
  namespace :api, constraints: {formant: 'json'} do
    scope module: :v1 do
      get 'user', to: 'users#show'
      # get 'matches', to: 'matches#show'  # removed
      # GearShaftDataset
      # get 'gear_shafts', to: 'gear_shafts#all'
      # get 'gear_shafts/metadata', to: 'gear_shafts#metadata'
      # get 'gear_temp', to: 'gear_shafts#temp_api'
      # LeafFailuer
      get 'leaf', to: 'leafs#all'
      post 'leaf/add_record',  to: 'leafs#add_record'
      get 'leaf/:id', to: 'leafs#get_single_record'
      put 'leaf/:id/update', to: 'leafs#update_recrod'
      post 'leaf/measures/add', to: 'leafs#add_measure'
      namespace :leaf do
        get 'failure_type/index', to: 'leaf_failure_types#index'
        post 'failure_type/create', to: 'leaf_failure_types#create'
        get 'failure_type/show', to: 'leaf_failure_types#show'
        put 'failure_type/update_record', to: 'leaf_failure_types#update'
        get 'failure_type/all_measures', to: 'leaf_failure_types#all_measures'
        get 'failure_type/top_three_measures', to: 'leaf_failure_types#top_three_measures'
        get 'failure_type/activities', to: 'leaf_failure_types#activities'
        get 'failure_type/failure', to: 'leaf_failure_types#failure'
        get 'failure_type/cause', to: 'leaf_failure_types#cause'
        post 'measure_type/create', to: 'leaf_measure_types#create'
        get 'measure_type/single_measure', to: 'leaf_measure_types#single_measure'
        post 'measure_type/update_record', to: 'leaf_measure_types#update'
        post 'measure_type/approve', to: 'leaf_measure_types#approve'
        get 'measure_type/update_success_rates', to: 'leaf_measure_types#update_success_rates'
      end
      # humidity api's
      namespace :humidity do
        resources :contracts, only: [:index, :create, :show, :update]
        post 'contracts/assign_sensor', to: 'contracts#assign_sensor'
        post 'contracts/remove_sensor', to: 'contracts#remove_sensor'
        resources :sensor_values, only: [:index, :create]
        resources :active_sensors, only: [:index, :create, :update] # show
        get 'active_sensors/sensors', to: 'active_sensors#sensors'
      end
    end
  end

end
