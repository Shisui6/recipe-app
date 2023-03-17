require "rails_helper"

describe "User signs up", type: :system do
  let(:name) { 'test' }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8) }

  before do
    visit new_user_registration_path
  end

  scenario "with valid data" do
    fill_in "user_name", with: name
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password
    click_button "Register"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_text "Hello"
  end

  scenario "invalid when email already exists" do
    user = create :user

    fill_in "user_name", with: name
    fill_in "user_email", with: user.email
    fill_in "user_password", with: password
    click_button "Register"

    expect(page).to have_no_text "Hello"
    expect(page).to have_text "Email has already been taken"
  end
end
