# Service called when a user joins a group.
# Users belong to groups via personas
# Usage:
#   GroupJoiner.new(User.first, Group.last, {screen_name: 'coolio'}).execute!
class GroupJoiner
  attr_accessor :user, :group, :options

  def initialize(user, group, options={})
    @user                 = user
    @group                = group
    @options              = options
    options[:screen_name] ||= user.username
  end

  def execute!
    user.personas.create!(options.merge({group: group}))
  end

end