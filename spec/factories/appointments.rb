# spec/factories/appointments.rb

FactoryGirl.define do
  factory :appointment do |f|
    f.start_time Time.now
    f.end_time   Time.now+2000
    f.user_id    7
  end
end
