Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "homepage#index"
  # we need to nest to display trips edit form
  # resources :passengers
  resources :drivers
  resources :trips, except: [:new, :create, :update]
  resources :passengers do
    resources :trips, only: [:new, :create, :update]
  end
end

#we might need to create a route for UPDATE that looks like this  passenger_trips POST   /passengers/:passenger_id/trips(.:format)
