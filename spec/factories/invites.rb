FactoryGirl.define do
  factory :invite do
    email "userpppp@example.com"
    association :event, :factory => [:event]
    token Digest::SHA1.hexdigest([Time.now].join)
  end
end