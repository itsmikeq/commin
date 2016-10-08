class CreatePostTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :post_topics do |t|
      t.references :post, foreign_key: true
      t.references :topic, foreign_key: true

      t.timestamps
    end
    add_index(:post_topics, [:post_id, :topic_id])
  end
end
