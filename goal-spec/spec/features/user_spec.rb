require 'spec_helper'
require 'rails_helper'

feature "user index page" do
  scenario "creating a user adds them to the index page" do
    sign_up("test_user")
    click_on "Sign Out"
    visit users_url

    expect(page).to have_content("test_user")
  end

  scenario "clicking a user takes them to their page" do
    sign_up("test_user")
    click_on "Goals for test_user"
    expect(page).to have_content "Public Goals"
  end
end
