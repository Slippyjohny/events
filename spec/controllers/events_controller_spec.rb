require 'rails_helper'
RSpec.describe EventsController, type: :controller do
  it "Expect to not have acces to event" do
    id=sign_in.id+1
    event = FactoryGirl.create(:event, user_id: id)
    get :show, id: event
    expect(response).to redirect_to(root_path)
    message = "You aren't allowed to do that."
    expect(flash[:alert]).to eq message
  end
  it "Expect to  have acces to event" do
    id=sign_in.id
    event = FactoryGirl.create(:event, user_id: id)
    get :show, id: event
    expect(response).to render_template("show")
  end
end