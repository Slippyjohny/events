require "rails_helper"
RSpec.feature "Users can create new events" do
  before do
    sign_in
    visit root_path
    click_link "Create new event"
  end

  scenario "with valid attributes" do
    fill_in "Place", with: "Odessa Place"
    select_date_and_time(DateTime.now+1.day, from: :event_time)
    select_date_and_time(DateTime.now+3.days, from: :event_end_time)
    fill_in "Description", with: "Ruby MeetUp"
    click_button "Create"
    expect(page).to have_content "Event was successfully created."
  end

  scenario "with invalid attributes" do
    fill_in "Place", with: "Od"
    select_date_and_time(DateTime.now-1.day, from: :event_time)
    select_date_and_time(DateTime.now+3.days, from: :event_end_time)
    fill_in "Description", with: "Ru"
    click_button "Create"
    expect(page).not_to have_content "Event was successfully created."
  end
end