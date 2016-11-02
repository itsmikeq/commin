puts "Seeding Friendships"
2.times do
  User.all.each do |user|
    printf('.')
    friend = User.all.sample
    if user.friends.include?(user)
      friend = User.all.sample
    end
    begin
      user.friends << friend
    rescue
      retry
    end
  end
end