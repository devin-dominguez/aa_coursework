require 'spec_helper'
require 'rails_helper'

feature "users can add comments to user pages" do

  scenario "form is not visible unless signed in" do
    sign_up("test_user")
    click_on "Sign Out"
    visit user_url(1)

    expect(page).to_not have_content("Add Comment")
  end

  scenario "can add comment through embedded form" do
    sign_up("test_user")
    click_on "Sign Out"

    sign_up("commenting_user")
    visit user_url(1)
    fill_in('comment', with: "Great job!")
    click_button "Add Comment"
    expect(page).to have_content("Great job!")
  end

end

feature "users can add comments to user goals" do
  scenario "form is visible when signed in" do
    sign_up("test_user")
    click_on "Add Goal"
    fill_in('goal', with: 'whatever 2016')
    choose('public')
    click_button('Add Goal')
    visit user_url(1)
    click_on "whatever 2016"

    expect(page).to have_content("Add Comment")
  end

  scenario "form is not visible when not signed in" do
    sign_up("test_user")
    click_on "Add Goal"
    fill_in('goal', with: 'whatever 2016')
    choose('public')
    click_button('Add Goal')
    click_on "Sign Out"
    visit user_url(1)
    click_on "whatever 2016"

    expect(page).to_not have_content("Add Comment")
  end

  scenario "can add comment through embedded form" do
    sign_up("test_user")
    click_on "Add Goal"
    fill_in('goal', with: 'whatever 2016')
    choose('public')
    click_button('Add Goal')
    click_on "Sign Out"


    sign_up("commenting_user")
    visit user_url(1)
    click_on "whatever 2016"
    fill_in('comment', with: "Great job!")
    click_button "Add Comment"
    expect(page).to have_content("Great job!")
  end
end
