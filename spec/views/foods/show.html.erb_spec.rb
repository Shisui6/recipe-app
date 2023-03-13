require 'rails_helper'

RSpec.describe 'foods/show', type: :view do
  before(:each) do
    assign(:food, Food.create!(
                    user: nil
                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
  end
end
