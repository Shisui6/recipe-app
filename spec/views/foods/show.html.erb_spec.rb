require 'rails_helper'

RSpec.describe 'foods/show', type: :view do
  let(:user) { User.create(name: 'Another_user', email: 'test2@gmail.com', password: '123123') }

  before(:each) do
    assign(:food,
           Food.create!('user' => user, 'name' => 'Pasta', 'measurement_unit' => 'grams', 'price' => 2,
                        'quantity' => 1.5))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
  end
end
