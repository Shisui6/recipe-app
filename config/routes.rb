Rails.application.routes.draw do
  devise_for :users
  
  root "recipes#index"

  resources :foods, only: [:index, :new, :create, :edit, :destroy, :update]
  resources :recipes
  resources :users
end
