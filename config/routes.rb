Rails.application.routes.draw do
  resources :users

  get '/change_request/:recycle_location_id', to: 'recycle_location_changes#create'
  
  resources :recycle_locations do
    resources :recycle_location_changes, only: :create
  end

  get 'pending_changes', to: 'recycle_locations#get_pending_changes'
  put 'apply_change', to: 'recycle_locations#update'
  post 'authenticate', to: 'authentication#authenticate'
end
