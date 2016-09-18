require 'seed-fu'
users = []
User.create!(
  :name => 'Admin',
  :email => 'admin@comin',
  :password => 'password',
  :password_confirmation => 'password',
  :roles => User::ROLE_ADMIN
)

20.times do |i|
  users.push **{
    username: FFaker::Internet.user_name,
    email: FFaker::Internet.email,
  }
end

users.each do |user|
  User.seed(:id, user)
end

