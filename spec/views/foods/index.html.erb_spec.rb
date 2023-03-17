require 'rails_helper'

RSpec.describe 'foods/index', type: :view do
  let(:user) { User.create(name: 'Another_user', email: 'test2@gmail.com', password: '123123') }

  before(:each) do
    assign(:foods, [
             Food.create!(
               'user' => user, 'name' => 'Pasta', 'measurement_unit' => 'grams', 'price' => 2, 'quantity' => 1.5
             ),
             Food.create!(
               'user' => user, 'name' => 'Pasta', 'measurement_unit' => 'grams', 'price' => 2, 'quantity' => 1.5
             )
           ])
  end

  it 'renders a list of foods' do
    render
    expect(response).to include('Foods')
  end
end
