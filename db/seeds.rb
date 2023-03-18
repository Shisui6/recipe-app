# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create(name: 'User', email: 'test@gmail.com', password: '123123')

food = Food.new(user: , name: 'Apple', measurement_unit: 'grams', price: 1, quantity: 2)

recipe = Recipe.new(user: , name: 'Pie' preparation_time: 1, cooking_time: 2, description: 'Nice disert to have after a meal')

recipe_food = RecipeFood.new(food: , recipe: , quantity: 4)