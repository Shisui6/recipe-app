class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, :preparation_time, :cooking_time, :description, presence: true
  validates :preparation_time, :cooking_time, comparison: { greater_than_or_equal_to: 0 }

  def total_cost_calculator
    @total_cost = 0
    recipe_foods.each do |recipe_food|
      @total_cost += (recipe_food.quantity * recipe_food.food.price) / recipe_food.food.quantity
    end
    @total_cost
  end
end
