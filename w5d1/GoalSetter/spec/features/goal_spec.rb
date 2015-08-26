require 'spec_helper'
require 'rails_helper'

feature "users have goals" do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:goal) { build(:goal) }

  before(:each) do
    login(user1)
  end

  scenario "create a goal from their profile" do
    visit user_url(user1)
    find("#new_goal").click
    fill_in 'Title', with: goal.title
    choose('Public')
    save_and_open_page
    find("#create").click
    expect(page).to have_content(goal.title)
  end

  scenario "users goals don't show up on other users profiles" do
    let(:goal1) {create(:goal, user: user1)}
    visit user_url(user2)
    expect(page).to_not have_content(goal1.title)
  end

  scenario "user can delete a goal" do
    visit user_url(user1)
    expect { find("#delete").click }.to change(user1.goals.count).by(-1)
  end

  scenario "user can update goal title" do
    visit user_url(user1)
    find("#edit").click
    expect(page).to have_content("Edit")
    expect(page).to have_content(goal1.title)
    fill_in 'Title', with: "Testing Edit"
    find("#submit").click
    expect(page).to have_content("Testing Edit")
  end

  scenario "user don't see links to create, edit, update, or delete other people's goals" do
    let(:goal2) { create(:goal, user: user2)}
    visit user_url(user2)
    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete")
    expect(page).to_not have_content("Create")
    expect(page).to_not have_content("Complete")
  end
end

feature "goals can be public or private" do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:goal) { create(:private_goal, user: user1) }

  scenario "users can mark goals as private" do
    login(user2)
    visit user_url(user1)
    expect(page).to_not have_content(goal.title)
  end

  scenario "users can mark goals as public" do
    login(user1)
    visit user_url(user1)
    find("#edit").click
    choose('Public')
    find("#submit").click
    logout
    login(user2)
    visit user_url(user1)
    expect(page).to have_content(goal.title)
  end
end

feature "Users can track completed goals" do
  scenario "users can mark goals as completed" do
    login(user1)
    visit user_url(user1)
    find("#complete").click
    expect(page).to have_content("COMPLETED")
  end
end
