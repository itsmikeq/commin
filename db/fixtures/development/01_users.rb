require 'seed-fu'
users = []
User.create!(
  :name => 'Admin',
  :email => 'admin@commin',
  :username => 'admin',
  :password => 'password',
  :password_confirmation => 'password',
  :roles => User::ROLE_ADMIN
)

20.times do |i|
  users.push **{
    name: "#{FFaker::Name.first_name} #{FFaker::Name.last_name}",
    username: FFaker::Internet.user_name,
    email: FFaker::Internet.email,
  }
end

users.each do |user|
  User.seed(:id, user)
end

