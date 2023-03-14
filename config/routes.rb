Rails.application.routes.draw do
  devise_for :users
  
  root "recipes#public"

  resources :foods
  resources :recipes
end
