json.extract! post, :id, :body, :created_at, :updated_at, :username
# json.reply_posts post.reply_posts, :id, :body, :created_at, :updated_at, :username

json.url post_url(post, format: :json)