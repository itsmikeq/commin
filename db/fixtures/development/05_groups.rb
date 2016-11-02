puts "Seeding Groups"
require 'seed-fu'
groups = []
20.times do |i|
  groups.push **{
    name:       "#{FFaker::Name.first_name}",
    permission: 1,
    owned_by:      User.first.to_global_id.to_s,
  }
end

groups.each do |group|
  Group.seed(:id, group)
end

