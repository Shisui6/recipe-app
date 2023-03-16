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

  def shopping_list
    @recipes = Recipe.includes(foods: [recipe_foods: [:quantity]]).where(user: current_user);
    foods_obj = {}
    @recipes.each do |recipe|
      recipe.foods.each do |food|
        name = food.name
        if foods_obj[name]
          foods_obj[name]['quantity'] += food.recipe_foods.quantity
          foods_obj[name]['price'] += food.price
        else
          foods_obj[name]['name'] = food.name
          foods_obj[name]['quantity'] = food.recipe_foods.quantity
          foods_obj[name]['price'] = food.price
        end
      end
    end

    @list = []
    Food.all.each do |food|
      @list << foods_obj[food.name] if foods_obj[food.name]
    end
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
