Rails.application.routes.draw do
  devise_for :users
  
  root "welcome#index"

  resources :foods
  resources :recipes do
    resources :recipe_foods, only: %i[new create update destroy]
    get '/recipe_shopping_list' => 'foods#recipe_shopping_list'
  end

  get '/public_recipes' => 'recipes#public'
  get '/general_shopping_list' => 'foods#general_shopping_list'
end
