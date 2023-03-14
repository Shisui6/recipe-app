Rails.application.routes.draw do
  devise_for :users
  
  root "recipes#index"

  resources :foods
  resources :recipes
  resources :users
end
