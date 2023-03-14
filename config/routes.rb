Rails.application.routes.draw do
  devise_for :users
  
  root "recipes#index"

  resources :foods, only: [:index, :new, :create, :edit, :destroy, :update]
  resources :recipes
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
