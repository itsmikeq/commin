puts "Seeding Friendships"
2.times do
  User.all.each do |user|
    user.friendships.create!(friend: User.all.sample)
  end
end