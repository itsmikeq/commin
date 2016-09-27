class AddReplyPostIdToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :reply_post_id, :integer, index: true
  end
end
