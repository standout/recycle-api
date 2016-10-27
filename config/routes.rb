Rails.application.routes.draw do
  resources :admins
  resources :recycle_locations do
    resources :recycle_location_changes, only: :create
  end

  get '/get_pending_changes', to: 'recycle_locations#get_pending_changes'
  put '/apply_change', to: 'recycle_locations#update'
end
