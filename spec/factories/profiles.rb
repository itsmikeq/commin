FactoryGirl.define do
  factory :profile do
    user { create(:user) }
    photo_url "https://dummyimage.com/52x52/000/fff.png"
    intro { FFaker::Lorem.sentence(3) }
    sex { %w(male female other).sample }
    religion { %w(Christian Jewish Agnostic).sample }
    political_party { %w(Libertarian Republican Democrat).sample }
    language { %w(English Spanish Hindi Mandarin).sample }
    nickname { FFaker::Name.first_name }
  end
end
