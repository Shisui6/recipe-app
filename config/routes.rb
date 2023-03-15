Rails.application.routes.draw do
  devise_for :users
  
  root "recipes#public"
  get "/shopping_list", to: "foods#shopping_list"

  resources :foods
  resources :recipes
end
