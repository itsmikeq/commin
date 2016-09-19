# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  body            :text(65535)
#  user_id         :integer
#  sent_to_user_id :integer
#  visibility      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_posts_on_sent_to_user_id  (sent_to_user_id)
#  index_posts_on_user_id          (user_id)
#  index_posts_on_visibility       (visibility)
#
# Foreign Keys
#
#  fk_rails_5b5ddfd518  (user_id => users.id)
#

# TODO: send all Posts to ES
# TODO: filter by public-ness of the post
class Post < ApplicationRecord
  include Visibility
  belongs_to :user
  belongs_to :sent_to_user, foreign_key: :sent_to_user_id, class_name: 'User'
  has_many :post_topics, dependent: :destroy
  has_many :topics, through: :post_topics

  scope :public_posts, -> { where(visibility: PUBLIC) }
  scope :private_posts, -> { where(visibility: PRIVATE) }
  scope :direct_posts, -> { where(visibility: DIRECT) }

  after_create :find_or_create_topics

  private if Rails.env.production?
  # Finds/creates topics by searching post body
  # TODO: Should be a background job
  def find_or_create_topics
    body.scan(/(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/).each do |words|
      words.each do |word|
        topics.find_or_create_by(tag: word.strip, user_id: user.id)
      end
    end
  end


end
