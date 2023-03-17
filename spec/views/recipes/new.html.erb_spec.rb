require 'rails_helper'

RSpec.describe 'recipes/new', type: :view do
  let(:user) { User.create(name: 'Another_user', email: 'test2@gmail.com', password: '123123') }

  before(:each) do
    assign(:recipe, Recipe.new(
                      name: 'MyString',
                      preparation_time: '9.99',
                      cooking_time: '9.99',
                      description: 'MyText',
                      public: false,
                      user: user
                    ))
  end

  it 'renders new recipe form' do
    render

    assert_select 'form[action=?][method=?]', recipes_path, 'post' do
      assert_select 'input[name=?]', 'recipe[name]'

      assert_select 'input[name=?]', 'recipe[preparation_time]'

      assert_select 'input[name=?]', 'recipe[cooking_time]'

      assert_select 'textarea[name=?]', 'recipe[description]'

      assert_select 'input[name=?]', 'recipe[public]'
    end
  end
end
