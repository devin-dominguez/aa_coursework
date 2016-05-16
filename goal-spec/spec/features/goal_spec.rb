require 'spec_helper'
require 'rails_helper'

feature "can add public goals to user page" do

  scenario "clicking add goal shows form" do
    sign_up("testing_username")
    click_on "Add Goal"
    expect(page).to have_content "Add a New Goal!"
  end

  scenario "adding public goals show up for all users" do
    sign_up("testing_username")
    click_on "Add Goal"
    fill_in('goal', with: 'whatever 2016')
    choose('public')
    click_button('Add Goal')
    expect(page).to have_content('whatever 2016')
  end
end

feature "can add private goals to user page" do

  before(:each) do
    sign_up("testing_username")
    click_on "Add Goal"
    fill_in('goal', with: 'whatever 2016')
    choose('private')
    click_button('Add Goal')
    click_button('Sign Out')

    sign_up("testing_username2")
    click_on "Add Goal"
    fill_in('goal', with: 'whenever 2016')
    choose('private')
    click_button('Add Goal')
  end

  scenario "private goals don't show up for other users" do
    visit('/users/1')
    expect(page).to_not have_content('Private Goals')
    expect(page).to_not have_content('whatever 2016')
  end

  scenario "private show up for own user" do
    expect(page).to have_content('Private Goals')
    expect(page).to have_content('whenever 2016')
  end

end

feature "clicking on goal goes to show page" do
  scenario "goal show page should have comments" do
    sign_up("testing_username")
    click_on "Add Goal"
    fill_in('goal', with: 'whatever 2016')
    choose('public')
    click_button('Add Goal')
    click_on("whatever 2016")

    expect(page).to have_content("Comments for whatever 2016")
  end
end
