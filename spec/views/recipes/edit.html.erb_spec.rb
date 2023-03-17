require 'rails_helper'

RSpec.describe 'recipes/edit', type: :view do
  let(:user) { User.create(name: 'Another_user', email: 'test2@gmail.com', password: '123123') }

  let(:recipe) do
    Recipe.create!(
      name: 'MyString',
      preparation_time: '9.99',
      cooking_time: '9.99',
      description: 'MyText',
      public: false,
      user: user
    )
  end

  before(:each) do
    assign(:recipe, recipe)
  end

  it 'renders the edit recipe form' do
    render

    assert_select 'form[action=?][method=?]', recipe_path(recipe), 'post' do
      assert_select 'input[name=?]', 'recipe[name]'

      assert_select 'input[name=?]', 'recipe[preparation_time]'

      assert_select 'input[name=?]', 'recipe[cooking_time]'

      assert_select 'textarea[name=?]', 'recipe[description]'

      assert_select 'input[name=?]', 'recipe[public]'
    end
  end
end
