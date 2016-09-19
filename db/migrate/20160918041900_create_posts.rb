class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.integer :sent_to_user_id, index: true
      t.integer :visibility, index: true

      t.timestamps
    end
  end
end
