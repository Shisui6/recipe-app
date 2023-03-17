class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource

  def new
    @recipe_food = RecipeFood.new
    @foods = []
    @ids = RecipeFood.where(recipe_id: params[:recipe_id]).pluck(:food_id)
    Food.where(user: current_user).each do |f|
      @foods << [f.name, f.id] unless @ids.include?(f.id)
    end
  end

  # GET /recipes/1/edit
  def edit
    @recipe_food = RecipeFood.includes(:food).find_by(id: params[:id])
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params)

    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to recipe_path(@recipe), notice: 'Ingredient was successfully added.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    @recipe_food = RecipeFood.find_by(id: params[:id])
    respond_to do |format|
      if @recipe_food.update(recipe_food_params)
        format.html { redirect_to recipe_url(params[:recipe_id]), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy

    respond_to do |format|
      format.html { redirect_to recipe_url, notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipes = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.require(:recipe_food).permit(:quantity).merge(recipe: Recipe.find(params[:recipe_id]))
  end
end
