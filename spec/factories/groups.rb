FactoryGirl.define do
  factory :group do
    name { FFaker::Name.first_name }
    permission 1
    owner { create(:user) }
    type ""
  end
end
