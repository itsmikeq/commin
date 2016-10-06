json.extract! post, :id, :body, :created_at, :updated_at, :username
# json.user do
#   json.user post.user.username
#   json.user_id post.user.id
# end
# json.sent_to_user do
#   json.sent_to_username post.sent_to_user.try(:username)
#   json.sent_to_user_id post.sent_to_user_id
# end
json.url post_url(post, format: :json)