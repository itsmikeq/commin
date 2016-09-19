class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :tag
      # The user who started the topic
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
