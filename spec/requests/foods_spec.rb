require 'rails_helper'

RSpec.describe '/foods', type: :request do
  let(:user) { User.create(name: 'Another_user', email: 'test2@gmail.com', password: '123123') }

  let(:valid_attributes) do
    { 'user' => user, 'name' => 'Pasta', 'measurement_unit' => 'grams', 'price' => 2, 'quantity' => 1.5 }
  end

  let(:valid_attributes2) do
    { 'name' => 'Pasta', 'measurement_unit' => 'grams', 'price' => 2, 'quantity' => 1.5 }
  end

  let(:invalid_attributes) do
    { 'user' => user, 'name' => 'Pasta', 'measurement_unit' => 'grams', 'price' => 'ten', 'quantity' => 1.5 }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Food.create! valid_attributes
      get foods_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      food = Food.create! valid_attributes
      get food_url(food)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_food_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      food = Food.create! valid_attributes
      get edit_food_url(food)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Food' do
        expect do
          Food.create! valid_attributes
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the created food' do
        post foods_url, params: { food: valid_attributes2 }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Food' do
        expect do
          Food.create! invalid_attributes
        end.to change(Food, :count).by(1)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post foods_url, params: { food: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { 'name' => 'Pasta', 'measurement_unit' => 'kilograms', 'price' => 1, 'quantity' => 2 }
      end

      it 'updates the requested food' do
        food = Food.create! valid_attributes
        patch food_url(food), params: { food: new_attributes }
        food.reload
      end

      it 'redirects to the food' do
        food = Food.create! valid_attributes
        patch food_url(food), params: { food: new_attributes }
        food.reload
        expect(response).to redirect_to(foods_url)
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        food = Food.create! valid_attributes
        patch food_url(food), params: { food: invalid_attributes }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested food' do
      food = Food.create! valid_attributes
      expect do
        delete food_url(food)
      end.to change(Food, :count).by(-1)
    end

    it 'redirects to the foods list' do
      food = Food.create! valid_attributes
      delete food_url(food)
      expect(response).to redirect_to(foods_url)
    end
  end
end
