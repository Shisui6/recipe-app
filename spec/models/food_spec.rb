require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'Another_user', email: 'test2@gmail.com', password: '123123') }

  describe 'Food is created' do
    let(:food) { Food.new(user:, name: 'Pasta', measurement_unit: 'grams', price: 2, quantity: 1.5) }

    it 'Creates a food in database' do
      expect(food).to be_valid
    end
  end
end
