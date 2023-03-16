class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[show public]
  load_and_authorize_resource

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.where(user_id: current_user.id).includes(:user)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @rc = RecipeFood.new
    @foods = RecipeFood.where(recipe_id: @recipe.id)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def public
    @recipes = Recipe.includes(:user, recipe_foods: %i[quantity food]).where(public: true).order(created_at: :desc)
    @costs = {}
    @recipes.each do |recipe|
      total = 0
      recipe.recipe_foods.each do |recipe_food|
        total += recipe_food.quantity * recipe_food.food.price
      end
      @costs[recipe] = total
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipes = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description,
                                   :public).merge(user: current_user)
  end
end
