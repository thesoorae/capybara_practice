require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in "Username", :with =>"Bleep"
      fill_in "Password", :with => "pasword"
      click_on "Create User"
    end

    scenario "redirects to user goals page after signup" do
      expect(page).to have_content "My Goals"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "Bleep"
    end

  end

end

feature "logging in" do
  before(:each) do
    user1 = create(:user)
    visit new_session_url
    fill_in "Username", :with => user1.username
    fill_in "Password", :with => user1.password
    click_on "Log In"
  end

  scenario "redirects to goals index page after login" do
    expect(page).to have_content "My Goals"
  end

  scenario "shows username on the homepage after login" do
    expect(page).to have_content "Blooby"
  end

end

feature "logging out" do
  before(:each) do visit new_session_url
  end

  scenario "begins with a logged out state" do
    expect(page).to have_content "Sign In"
  end

  scenario "doesn't show username on the homepage after logout" do
      user1 = create(:user)
      fill_in "Username", :with => user1.username
      fill_in "Password", :with => user1.password
      click_on "Log In"
      click_on "Sign Out"

    expect(page).to_not have_content "Blooby"
  end

end
