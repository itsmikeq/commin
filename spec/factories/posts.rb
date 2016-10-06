FactoryGirl.define do
  factory :post do
    body { FFaker::Lorem.sentence(9) }
    user_id { create(:user).id }
    factory :post_response do
      reply_post_id { create(:post) }
    end
    trait :direct do
      sent_to_user_id { create(:user).id }
      visibility Post::DIRECT
    end
    trait :private do
      visibility Post::PRIVATE
    end
    factory :private_post, traits: [:private]
    factory :direct_post, traits: [:direct]
    factory :direct_message, traits: [:direct]
  end
end
