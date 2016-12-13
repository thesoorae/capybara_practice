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
    expect(page).to have_content "this is my private goal"
  end
  scenario "redirects to user's goals page" do
    expect(page).to have_content "My Goals"
  end
end

feature "user can update a goal" do
  before(:each) do
    create_goal
    click_on "Edit Goal"
  end
  scenario "has an update goal form" do
    expect(page).to have_content "Edit Goal"
  end

  scenario "form has goal info pre-filled" do
    val = find_field('Goal').value
    expect(val).to eq("this is my private goal")
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
      before(:each) do
        create_public_goal
      end

  scenario "user's goals page contains public and private goals" do
    expect(page).to have_content "this is my public goal"
    expect(page).to have_content "this is my private goal"
  end
end

feature "user can remove a goal" do
  before(:each) do
    create_three_goals
  end
  scenario "page contains a delete button for each goal" do
    expect(page).to have_button("Delete Goal", count: 3)
    click_on("Delete Goal", match: :first)
    expect(page).to have_button("Delete Goal", count: 2)
  end
  scenario "goal is no longer listed after deletion" do
    click_on("Delete Goal", match: :first)
    expect(page).to_not have_content "this is my private goal"
  end
end

feature "other users can see public goals" do
  before(:each) do
    create_new_user
  end

  scenario "each page has a link to all the users" do

    expect(page).to have_link("Users")
  end
  scenario "private goals do not appear to other users" do
    visit user_url(User.first)
    expect(page).to_not have_content("this is my private goal")
  end

  scenario "all public goals are listed" do
    visit user_url(User.first)
    expect(page).to have_content("this is my public goal")
    expect(page).to have_content("third goal")
  end

end

feature "user can mark a goal as completed" do
  before(:each) do create_three_goals
  end 

  scenario "page contains button for completed goal" do
    expect(page).to have_button("Mark as Completed", count: 3)
  end
  scenario "completed goals appear under list titled Completed Goals" do
    click_on "Mark as Completed", match: :first
    expect(page).to have_content "Completed Goals"
  end
end
