require 'spec_helper'
require 'rails_helper'


feature "user adds a goal" do
  before(:each) do
    create_goal
  end

  scenario "has a new goal form" do
    expect(page).to have_content "New Goal"
  end
  scenario "goal appears on the page when added" do
    expect(page).to have_content "this is my goal"
  end
  scenario "redirects to user's goals page" do
    expect(page).to have_content "My Goals"
  end
end

feature "user can update a goal" do
  before(:each) do
    create_goal
    click_on "Edit Goal"
    save_and_open_page
  end
  scenario "has an update goal form" do
    expect(page).to have_content "Edit Goal"
  end

  scenario "form has goal info pre-filled" do
    expect(page).to have_content "this is my goal"
  end
  scenario "redirects to user's goals page" do
    fill_in "Goal", :with => "this is my new goal"
    click_on "Update Goal"
    expect(page).to have_content "My Goals"
  end
  scenario "new page contains updated info" do
    fill_in "Goal", :with => "this is my new goal"
    click_on "Update Goal"
    expect(page).to have_content "this is my new goal"
  end
end

feature "user can view all their goals" do
  scenario "user's goals page contains public and private goals"
  scenario "goals page doesn't show completed goals"
end

feature "user can remove a goal" do
  scenario "page contains a delete button for each goal"
  scenario "goal is no longer listed after deletion"
end

feature "other users can see public goals" do
  scenario "each page has a link to all the users"
  scenario "private goals do not appear to other users"
  scenario "all public goals are listed"
end

feature "user can mark a goal as completed" do
  scenario "page contains button for completed goal"
  scenario "completed goals appear under list titled Completed Goals"
end
