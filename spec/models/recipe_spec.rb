require 'rails_helper'

RSpec.describe Recipe, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

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
