class FoodsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /foods or /foods.json
  def index
    @current_user = current_user
    @foods = Food.where(user_id: current_user)
  end

  # GET /foods/new
  def new
    @current_user = current_user
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit; end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params.merge(user: current_user))

    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_path, notice: 'Food was successfully added.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to foods_path, notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def general_shopping_list
    @all_foods = Food.all
    @recipes = Recipe.includes(recipe_foods: [:food]).where(user: current_user)
    @foods = {}
    @total_cost = 0
    @food_count = 0
    @recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        name = recipe_food.food.name
        if @foods[name]
          @foods[name] += recipe_food.quantity
        else
          @food_count += 1
          @foods[name] = recipe_food.quantity
        end
      end
      @total_cost += recipe.total_cost_calculator
    end
  end

  def recipe_shopping_list
    @recipe = Recipe.includes(recipe_foods: %i[food]).find_by(id: params[:recipe_id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
