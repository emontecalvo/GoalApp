require 'rails_helper'
require 'spec_helper'

feature 'creating a public goal' do
  before(:each) do
    sign_up_as_testing_username
    click_on 'Create New Goal'
    fill_in "Title", with: "Make the perfect sandwich"
    fill_in "Description", with: "Its gon be good"
    click_button "Create Goal"
  end
  scenario 'goal shows up goals index page' do
    expect(page).to have_content("Make the perfect sandwich")
  end

  scenario 'goal shows up on goal show page' do
    click_on "Make the perfect sandwich"
    expect(page).to have_content("Its gon be good")
  end

end

feature 'creating a private goal' do
  before(:each) do
    sign_up_as_testing_username
    click_on 'Create New Goal'
    fill_in "Title", with: "Make the perfect sandwich"
    fill_in "Description", with: "Its gon be good"
    page.check("Private")
    click_button "Create Goal"
  end
  scenario 'goal does not show up on goals index page' do
    click_on 'All Goals'
    expect(page).not_to have_content("Make the perfect sandwich")
  end


  scenario 'goal does show up on user show page' do
    expect(page).to have_content("Make the perfect sandwich")
  end

  scenario 'other users cannot see the goal on user show page' do
    click_button 'Log Out'
    sign_up("goal_spyer")
    visit user_url(1)
    expect(page).not_to have_content("Make the perfect sandwich")
  end

end

feature 'editing a goal' do
  before(:each) do
    sign_up_as_testing_username
    click_on 'Create New Goal'
    fill_in "Title", with: "Make the perfect sandwich"
    fill_in "Description", with: "Its gon be good"
    click_button "Create Goal"
  end
  scenario 'user can edit his goal' do
    click_on "Make the perfect sandwich"
    click_on 'Edit Goal'
    fill_in "Title", with: 'Make the perfect chicken sandwich'
    fill_in "Description", with: 'Yum!'
    click_button 'Update Goal'
    expect(page).to have_content('Make the perfect chicken sandwich')
  end
  scenario 'other people cannot edit other people\'s goals' do
    click_button 'Log Out'
    sign_up("goal_spyer")
    visit goals_url
    click_on('Make the perfect sandwich')
    expect(page).not_to have_content('Edit Goal')
  end
end

feature 'deleting a goal' do
  before(:each) do
    sign_up_as_testing_username
    click_on 'Create New Goal'
    fill_in "Title", with: "Make the perfect sandwich"
    fill_in "Description", with: "Its gon be good"
    click_button "Create Goal"
  end
  scenario 'user can delete his own goal.' do
    click_on "Make the perfect sandwich"
    click_on 'Delete Goal'
    expect(page).not_to have_content("Make the perfect sandwich")
  end
  scenario "user can't delete somebody else's goal" do
    click_button "Log Out"
    sign_up("goal_spyer")
    visit goals_url
    click_on("Make the perfect sandwich")
    expect(page).not_to have_content("Delete Goal")
  end
end
