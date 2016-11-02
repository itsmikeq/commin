puts "Seeding Personas"
require 'seed-fu'
personas = []
User.pluck(:id).each do |user_id|
  personas.push **{
    user_id:     user_id,
    screen_name: FFaker::Internet.user_name,
    group:       Group.all.sample
  }
end

personas.each do |persona|
  Persona.seed(:id, persona)
end

