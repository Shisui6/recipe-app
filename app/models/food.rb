class Food < ApplicationRecord
  belongs_to :user
  has_many :recipes

  validates :name, :measurement_unit, :price, :quantity, presence: true
  validates :price, :quantity, comparison: { greater_than_or_equal_to: 0 }
end
