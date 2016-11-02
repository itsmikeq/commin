FactoryGirl.define do
  factory :persona do
    user { create(:user) }
    screen_name { FFaker::Internet.user_name }
    group { create(:group) }
  end
end
