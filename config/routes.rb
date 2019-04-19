Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # we need to nest to display trips edit form
  resources :passengers
  resources :drivers
  resources :trips
end
