Rails.application.routes.draw do
  resources :foods, only: [:index, :new, :create, :edit, :destroy]
  resources :recipes
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'recipes#public'
end
