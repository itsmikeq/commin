# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_friendships_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_e3733b59b7  (user_id => users.id)
#

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => :friend_id
  validates_uniqueness_of :friend, scope: :user
end
