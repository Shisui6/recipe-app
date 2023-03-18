require 'rails_helper'

RSpec.describe 'foods/edit', type: :view do
  let(:user) { User.create(name: 'Another_user', email: 'test2@gmail.com', password: '123123') }

  let(:food) do
    Food.create!(
      'user' => user, 'name' => 'Pasta', 'measurement_unit' => 'grams', 'price' => 2, 'quantity' => 1.5
    )
  end

  before(:each) do
    assign(:food, food)
  end

  it 'renders the edit food form' do
    render
    expect(response).to include('Update')
  end
end
