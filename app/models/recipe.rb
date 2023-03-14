class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, :preparation_time, :cooking_time, :description, :public, presence: true
  validates :preparation_time, :cooking_time, comparison: { greater_than_or_equal_to: 0 }
end
