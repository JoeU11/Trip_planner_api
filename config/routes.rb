Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/users" => "users#create"

  post "/sessions" => "sessions#create"

  post "/trips" => "trips#create"

  get "trips" => "trips#index"

  get "trips/:id" => "trips#show"

  patch "trips/:id" => "trips#update"

  delete "trips/:id" => "trips#destroy"

  post "participants" => "participants#create"
end
