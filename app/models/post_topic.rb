# == Schema Information
#
# Table name: post_topics
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_post_topics_on_post_id               (post_id)
#  index_post_topics_on_post_id_and_topic_id  (post_id,topic_id)
#  index_post_topics_on_topic_id              (topic_id)
#
# Foreign Keys
#
#  fk_rails_a07bbf39f4  (topic_id => topics.id)
#  fk_rails_d43d36167e  (post_id => posts.id)
#

class PostTopic < ApplicationRecord
  belongs_to :post
  belongs_to :topic
end
