puts "Seeding Friendships"
2.times do
  User.all.each do |user|
    printf('.')
    friend = User.all.sample
    if user.friends.include?(user)
      friend = User.all.sample
    end
    tries = 0
    begin
      user.friends << friend
    rescue => e
      tries += 1
      retry unless tries > 3
    end
  end
end

puts "Done with friends"
