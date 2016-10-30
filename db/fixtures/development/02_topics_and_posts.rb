puts "Seeding topics and posts"
require 'seed-fu'

# Only the sending user can see the post
date1 = (Time.now - 1.week)
date2 = Time.now
100.times do |i|
  user = User.all.sample
  Post.create!(
    body: ("##{FFaker::Lorem.word.capitalize} " + FFaker::Lorem.sentence(40) + " ##{FFaker::Lorem.word.capitalize}"),
    user_id: user.id,
    visibility: Post.visibility_levels[:private],
    updated_at: Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
  )
end

# Only the sending user and the receiver can see the post
100.times do |i|
  user = User.all.sample
  Post.create!(
    body: ("##{FFaker::Lorem.word.capitalize} " + FFaker::Lorem.sentence(40) + " ##{FFaker::Lorem.word.capitalize}"),
    user_id: user.id,
    sent_to_user: user.friends.sample,
    visibility: Post.visibility_levels[:direct],
    updated_at: Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
  )
end

# Posts sent to admin
admin = User.first
30.times do |i|
  Post.create!(
    body: ("##{FFaker::Lorem.word.capitalize} " + FFaker::Lorem.sentence(40) + " ##{FFaker::Lorem.word.capitalize}"),
    user_id: User.all.sample.id,
    sent_to_user: admin,
    visibility: Post.visibility_levels[:direct],
    updated_at: Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
  )
end

# Public post
1000.times do |i|
  user = User.all.sample
  Post.create!(
    body: ("##{FFaker::Lorem.word.capitalize} " + FFaker::Lorem.sentence(40) + " ##{FFaker::Lorem.word.capitalize}"),
    user_id: user.id,
    visibility: Post.visibility_levels[:public],
    updated_at: Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
  )
end

