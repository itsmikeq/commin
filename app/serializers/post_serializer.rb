class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :user, :sent_to_user, :created_at, :updated_at, :reply_post
  has_many :reply_posts
end
