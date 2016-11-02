puts "Seeding Profiles"
require 'seed-fu'
profiles = []
User.pluck(:id).each do |user_id|
  profiles.push **{
    user_id:         user_id,
    photo_url:       "https://dummyimage.com/52x52/000/fff.png",
    intro:           FFaker::Lorem.sentence(3),
    nickname:        FFaker::Name.first_name,
    sex:             %w(male female other).sample,
    religion:        %w(Christian Jewish Agnostic).sample,
    political_party: %w(Libertarian Republican Democrat).sample,
    language:        %w(English Spanish Hindi Mandarin).sample
  }
end

profiles.each do |profile|
  Profile.seed(:id, profile)
end

