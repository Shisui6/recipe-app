require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/foods', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Food. As you add validations to Food, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
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
          post foods_url, params: { food: valid_attributes }
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the created food' do
        post foods_url, params: { food: valid_attributes }
        expect(response).to redirect_to(food_url(Food.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Food' do
        expect do
          post foods_url, params: { food: invalid_attributes }
        end.to change(Food, :count).by(0)
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
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested food' do
        food = Food.create! valid_attributes
        patch food_url(food), params: { food: new_attributes }
        food.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the food' do
        food = Food.create! valid_attributes
        patch food_url(food), params: { food: new_attributes }
        food.reload
        expect(response).to redirect_to(food_url(food))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        food = Food.create! valid_attributes
        patch food_url(food), params: { food: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
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
