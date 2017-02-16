FactoryGirl.define do
  factory :event do
    place "Some Events Place"
    time Time.now+1.day
    end_time Time.now+2.days
    description "Description again and again"
    user_id 1
  end


end