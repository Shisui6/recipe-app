require 'rails_helper'

RSpec.describe '/recipes', type: :request do
  let(:valid_attributes) do
    { user_id: User.first.id, name: 'test', preparation_time: 0, cooking_time: 0, description: 'yum' }
  end

  let(:invalid_attributes) do
    { user_id: nil, name: nil, preparation_time: nil, cooking_time: nil, description: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get recipes_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      recipe = Recipe.create! valid_attributes
      get recipe_url(recipe)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_recipe_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      recipe = Recipe.create! valid_attributes
      get edit_recipe_url(recipe)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with invalid parameters' do
      it 'does not create a new Recipe' do
        expect do
          post recipes_url, params: { recipe: invalid_attributes }
        end.to change(Recipe, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post recipes_url, params: { recipe: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        recipe = Recipe.create! valid_attributes
        patch recipe_url(recipe), params: { recipe: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested recipe' do
      recipe = Recipe.create! valid_attributes
      expect do
        delete recipe_url(recipe)
      end.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the recipes list' do
      recipe = Recipe.create! valid_attributes
      delete recipe_url(recipe)
      expect(response).to redirect_to(recipes_url)
    end
  end

  describe '#public' do
    let(:user) { User.create(name: 'Another_user', email: 'test2@gmail.com', password: '123123') }

    let(:food) { Food.create(user:, name: 'Apple', measurement_unit: 'grams', price: 1, quantity: 2) }
    let(:food2) { Food.create(user:, name: 'Suger', measurement_unit: 'grams', price: 1, quantity: 5) }
    let(:recipe) do
      Recipe.create(user:, name: 'Pie', preparation_time: 1, cooking_time: 2,
                    description: 'Nice disert to have after a meal')
    end
    let(:recipe_food) { RecipeFood.create(food:, recipe:, quantity: 4) }
    let(:recipe_food2) { RecipeFood.create(food: food2, recipe:, quantity: 6) }

    it 'returns the total cost of one recipe' do
      recipe
      recipe_food
      recipe_food2

      expect(recipe.total_cost_calculator).to eq 3.2
    end
  end
end
