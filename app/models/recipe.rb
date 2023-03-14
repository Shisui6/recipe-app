class Recipe < ApplicationRecord
  belongs_to :user
  has_many :foods

  validates :name, :preparation_time, :cooking_time, :description, presence: true
  validates :preparation_time, :cooking_time, comparison: { greater_than_or_equal_to: 0 }
end
