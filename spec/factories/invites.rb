FactoryGirl.define do
  factory :invite do
    email "userpppp@example.com"
    token Digest::SHA1.hexdigest([event_id, Time.now, rand].join)

  end


end