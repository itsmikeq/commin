# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  tag        :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_7b812cfb44  (user_id => users.id)
#

# TODO: send all topics to ES
class Topic < ApplicationRecord
  has_many :post_topics
  has_many :posts, through: :post_topics
  belongs_to :user
  # See what users are talking about
  has_many :users, through: :posts
end
