require 'spec_helper'

describe Event do

  it "time shoud be valid" do
    time=Time.now+2.hour
    end_time=time+1.day
    user=create(:user)
    event=create(:event, time: "#{time}", end_time: "#{end_time}")
  end

  it "time shoud_not  be valid" do
    time=Time.now
    end_time=time+1.minute
    user=create(:user)
    event=create(:event, time: "#{time}", end_time: "#{end_time}")
  end

end