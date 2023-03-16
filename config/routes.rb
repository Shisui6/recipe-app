Rails.application.routes.draw do
  devise_for :users
  
  root "welcome#index"

  resources :foods
  resources :recipes do
    resources :recipe_foods, only: %i[new create update destroy]
  end

  get '/public_recipes' => 'recipes#public'
end
