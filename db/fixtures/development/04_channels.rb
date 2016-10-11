require 'seed-fu'
# WIth tags
50.times do |i|
  user = User.all.sample
  Message.create(
    body: ("##{FFaker::Lorem.word.capitalize} " + FFaker::Lorem.sentence(10) + " ##{FFaker::Lorem.word.capitalize} ") + FFaker::Lorem.sentence(10),
    created_by: user.username,
    visibility: Post.visibility_levels[Post.visibility_levels.keys.sample]
  )
end
# With mentions and Tags
50.times do |i|
  user = User.all.sample
  user1 = User.all.sample
  user2 = User.all.sample
  Message.create(
    body: ("##{FFaker::Lorem.word.capitalize} @#{user1.username}" + FFaker::Lorem.sentence(10) + " ##{FFaker::Lorem.word.capitalize} @#{user2.username}") + FFaker::Lorem.sentence(10),
    created_by: user.username,
    visibility: Post.visibility_levels[Post.visibility_levels.keys.sample]
  )
end
