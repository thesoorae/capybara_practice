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

    scenario "redirects to goals index page after singup" do
      expect(page).to have_content "Goals Index Page"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "Bleep"
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login"

end

feature "logging out" do

  scenario "begins with a logged out state"

  scenario "doesn't show username on the homepage after logout"

end
