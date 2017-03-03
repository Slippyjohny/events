require "rails_helper"
RSpec.feature "Users can create new events" do
  DatabaseCleaner.clean
  let(:invite) { FactoryGirl.create(:invite) }
  it "Expect to must be attached" do
    visit sign_up_url(invite_token: invite.token)
    fill_in "Email", with: "kolya123123123@gmail.com"
    fill_in "Password", with: "mypass12"
    click_button "Sign up"
    expect(page).to have_content "#{invite.event.place}"
  end
end