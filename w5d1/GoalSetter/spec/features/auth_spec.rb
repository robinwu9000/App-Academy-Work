require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'Username', :with => "testing_username"
      fill_in 'Password', :with => "password"
      find('#submit').click
      expect(page).to have_content "testing_username"
    end
  end

end

feature "logging in" do
  let(:user) { create(:user) }
  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in 'Username', :with => user.username
    fill_in 'Password', :with => user.password
    find('#login').click
    expect(page).to have_content "#{user.username}"
  end

end

feature "logging out" do
  let(:user) { create(:user) }
  before(:each) do
    login(user)
  end

  scenario "begins with logged in state" do
    expect(page).to have_content "#{user.username}"
  end

  scenario "doesn't show username on the homepage after logout" do
    find('#logout').click
    expect(page).not_to have_content "#{user.username}"
  end

end
