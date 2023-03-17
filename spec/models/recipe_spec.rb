require 'rails_helper'

RSpec.describe Recipe, type: :model do
  user = User.create(name: 'test', email: 'test@gmail.com', password: 'qwerty')
  subject { Recipe.create(user_id: user.id, name: 'test', preparation_time: 0, cooking_time: 0, description: 'yum') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'preparation_time should be present' do
    subject.preparation_time = nil
    expect(subject).to_not be_valid
  end

  it 'cooking_time should be present' do
    subject.cooking_time = nil
    expect(subject).to_not be_valid
  end

  it 'description should be present' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'preparation_time must be greater than 0' do
    subject.preparation_time = -5
    expect(subject).to_not be_valid
  end

  it 'cooking_time must be greater than 0' do
    subject.cooking_time = -5
    expect(subject).to_not be_valid
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
