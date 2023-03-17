require 'rails_helper'

RSpec.describe 'foods/new', type: :view do
  let(:user) { User.create(name: 'Another_user', email: 'test2@gmail.com', password: '123123') }

  before(:each) do
    assign(:food, Food.new(
                    'user' => user, 'name' => 'Pasta', 'measurement_unit' => 'grams', 'price' => 2, 'quantity' => 1.5
                  ))
  end

  it 'renders new food form' do
    render
    expect(response).to include('New food')
  end
end
