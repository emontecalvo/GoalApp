require 'rails_helper'
require 'spec_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => "testing_username"
      fill_in 'Password', :with => 'biscuits'
      click_on "Create User"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "testing_username"
    end
  end
end

feature "the not-signed in state" do
  scenario "doesn't see a logout button if not signed in" do
    visit new_session_url
    expect(page).not_to have_content "Log Out"
  end
end

feature "logging in" do
  before(:each) do
    sign_up_as_testing_username
  end

  scenario "shows username on the homepage after login" do
    expect(page).to have_content "testing_username"
  end
end

feature "logging out" do

  scenario "doesn't show username on the homepage after logout" do
    sign_up_as_testing_username
    click_on "Log Out"
    visit new_session_url
    fill_in 'Username', :with => "testing_username"
    fill_in 'Password', :with => "password"
    click_on "Sign In"
    click_on "Log Out"
    expect(page).not_to have_content ("testing_username")
  end
end
