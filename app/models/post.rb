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
#  reply_post_id   :integer
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
  include ElasticsearchSearchable
  include Indexable

  belongs_to :user
  belongs_to :sent_to_user, foreign_key: :sent_to_user_id, class_name: 'User'
  belongs_to :post, foreign_key: :reply_post_id, class_name: 'Post'
  has_many :post_topics
  has_many :topics, through: :post_topics, dependent: :destroy
  has_many :reply_posts, foreign_key: :reply_post_id, class_name: 'Post'
  validates_presence_of :user
  validates_presence_of :body

  scope :public_posts, -> { where(visibility: PUBLIC) }
  scope :private_posts, -> { where(visibility: PRIVATE) }
  scope :direct_posts, -> { where(visibility: DIRECT) }

  after_create :find_or_create_topics
  after_create :push_into_es
  delegate :username, to: :user


  def as_indexed_json(options={})
    self.as_json(
      include: { user: { only: :username},
                 sent_to_user:    { only: :username },
                 reply_posts: {methods: [:as_indexed_json]},
      })
  end

  # give extra attributes to the default json
  def as_json(**options)
    HashWithIndifferentAccess.new(super(options).merge(username: username))
  end

  private if Rails.env.production?
  # Finds/creates topics by searching post body
  # TODO: Should be a background job
  def find_or_create_topics
    body.scan(/(?:\s|^)(?:#(?!(?:\d+|\w+?_|_\w+?)(?:\s|$)))(\w+)(?=\s|$)/).each do |words|
      words.each do |word|
        topic = Topic.find_or_create_by(tag: word.strip)
        topics << topic
      end
    end
  rescue => e
    puts e.message
  end

  def push_into_es
    # TODO: push data into elasticsearch
  end

end
