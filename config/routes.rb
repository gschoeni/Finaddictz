Finaddictz::Application.routes.draw do
  resources :notifications

  resources :rivers

  resources :property_posts

  resources :messages
  
  resources :conversations

  resources :ratings

  resources :env_prefs

  resources :locations

  resources :angler_posts

  resources :guide_posts

  resources :fishing_methods

  resources :fish_species


  resources :user_sessions
  match "/logout" => "user_sessions#destroy"
  match "/login" => "user_sessions#new"
  match "/register" => "users#new"

  match "/map" => "map#index"

  #for changing a trips status from open to pending
  match 'guide_posts/book_trip/:id/:user_id' => 'guide_posts#book_trip', :as => 'book_trip'

  #for confirming a user after they register 
  match 'users/confirm/:id/:sha' => 'users#confirm'

  #for changing a users role
  match 'users/:id/change_role/:role' => 'users#change_role', :as => 'change_role_user'


  #enabling and disabling a user
  put "users/:id/toggle_enabled" => 'users#toggle_enabled', :as => 'toggle_enabled_user'

  put "guide_posts/:id/flag_as_abused" => 'guide_posts#flag_as_abused', :as => 'flag_as_abused'

  resources :users

  root :to => "user_sessions#new"


end
