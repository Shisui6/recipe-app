require 'rails_helper'

describe 'Recipe page', type: :system do
  before do
    @user = create :user
    visit new_user_session_path

    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Log in'
  end

  scenario 'index page' do
    expect(page).to have_text "Hello #{@user.name}"
    expect(page).to have_button 'New recipe'
    expect(page).to have_current_path recipes_path
  end

  scenario 'new page' do
    click_button 'New recipe'

    expect(page).to have_text 'Recipe details'
    expect(page).to have_current_path new_recipe_path
  end
end
