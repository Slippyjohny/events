require "rails_helper"
RSpec.feature "Users can create new events" do
  let(:event) { FactoryGirl.create(:event) }
  let(:invite) { FactoryGirl.create(event.invites.create(FactoryGirl.create(:invite))) }
  it "Expect to must be attached" do
    DatabaseCleaner.clean
    visit sign_up_url(invite_token: invite.token)
    fill_in "Email", with: "kolya@gmail.com"
    fill_in "Password", with: "mypass12"
    click_button "Sign Up"
    expect(page).to have_content "#{event.place}"
  end
end