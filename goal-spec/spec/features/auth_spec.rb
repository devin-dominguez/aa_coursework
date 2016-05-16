require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      sign_up("testing_username")
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content "testing_username"
    end

  end

end

feature "logging in" do
  before(:each) do
    sign_up("testing_username")
    click_on "Sign Out"
    sign_in("testing_username")
  end

  scenario "shows the username on the homepage after login" do
    expect(page).to have_content "testing_username"
  end
end

feature "Logging Out" do
  scenario "doesn't show username on the homepage after logout" do
    sign_up("testing_username")
    click_on "Sign Out"

    expect(page).to_not have_content "testing_username"
  end
end
