require 'spec_helper'
require 'rails_helper'

feature "allows comments on users" do
  before(:each) do
    visit_other_user
  end
  scenario "there's a form to comment on user" do
    expect(page).to have_content("Comment on this User")
  end
end

feature "allows comments on goals" do
  before(:each) do
    visit_other_user
  end

  scenario "there's a button to comment on goal" do
    expect(page).to have_button("Comment on this Goal")
  end

  scenario "there's a button to view comments on goal" do
    expect(page).to have_button("View Comments on this Goal")
  end

end

feature "comments appear on user's page" do
  before(:each) do
    visit_other_user
    fill_in "Comment", :with => "You are awesome!"
    click_on "Make Comment"
  end
  scenario "when user adds a comment on another user, it appears" do
    expect(page).to have_content("You are awesome!")
  end
  scenario "when button to view comments is clicked, page displays goals comments" do
    click_on "Comment on this Goal", match: :first 
    fill_in "Comment", :with => "Nice Goal"
    click_on "Submit"
    expect(page).to have_content("Nice Goal")
  end
end
feature "user can delete comment they made" do
  scenario "there's a button to delete comment"
  scenario "comment is delete from page"
end
feature "user must be logged in to make comment" do
  scenario "there is no add comment button if user is not logged in"
end
